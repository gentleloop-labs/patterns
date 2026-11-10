import AVFoundation
import PatternsCore
import PhotosUI
import SwiftUI

extension MaterialType {
    var systemImage: String {
        switch self {
        case .script: "text.alignleft"
        case .loopTape: "waveform"
        case .image: "photo"
        case .link: "link"
        }
    }

    func label(_ s: Strings) -> String {
        switch self {
        case .script: s.exposureMaterialsText(key: "typeScript")
        case .loopTape: s.exposureMaterialsText(key: "typeLoopTape")
        case .image: s.exposureMaterialsText(key: "typeImage")
        case .link: s.exposureMaterialsText(key: "typeLink")
        }
    }
}

/// `ExposureMaterialsScreen` from `lib/mobile/screens/exposure_materials_screen.dart`:
/// scripts, loop tapes, images and links to practise with. With a step
/// set, it shows that step's materials and new ones attach to it. Pro.
struct ExposureMaterialsScreen: View {
    var linkedStepID: Int64?
    var linkedHierarchyID: Int64?

    @Environment(AppModel.self) private var model
    @State private var materials: Loadable<[ExposureMaterial]> = .loading
    @State private var adding: MaterialType?

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.exposureMaterialsText(key: key) }
        let items = (materials.value ?? []).filter { linkedStepID == nil || $0.linkedStepId == linkedStepID }
        List {
            Section {
            } header: {
                Text(text("subtitle"))
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            SectionIntroSection(id: "exposureMaterials")
            switch materials {
            case .loading:
                ProgressView().frame(maxWidth: .infinity).listRowBackground(Color.clear)
            case .failed:
                Text(text("loadError")).foregroundStyle(.secondary).listRowBackground(AppColors.card)
            case .loaded where items.isEmpty:
                Section {
                    VStack(alignment: .leading, spacing: 6) {
                        Image(systemName: "folder").font(.title2).foregroundStyle(AppColors.accent)
                        Text(text("emptyTitle")).font(.headline).accessibilityAddTraits(.isHeader)
                        Text(text("emptyBody")).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
                        addMenu(strings) {
                            Text(text("addAction"))
                        }
                        .buttonStyle(.accentProminent)
                        .buttonBorderShape(.capsule)
                        .padding(.top, 6)
                    }
                    .padding(.vertical, 6)
                }
                .listRowBackground(AppColors.card)
            case .loaded:
                Section {
                    ForEach(items, id: \.id) { MaterialRow(material: $0) }
                }
                .listRowBackground(AppColors.card)
            }
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(text("title"))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                addMenu(strings) { Label(text("newAction"), systemImage: "plus") }
            }
        }
        .liveQuery(model.database, into: $materials) { db in try ExposureMaterial.all().fetchAll(db) }
        .sheet(item: $adding) { type in
            MaterialEditor(type: type, linkedStepID: linkedStepID, linkedHierarchyID: linkedHierarchyID)
        }
    }

    /// `_chooseType` as a native menu.
    private func addMenu<Label: View>(_ strings: Strings, @ViewBuilder label: () -> Label) -> some View {
        Menu {
            ForEach(MaterialType.allCases, id: \.self) { type in
                Button(type.label(strings), systemImage: type.systemImage) { adding = type }
            }
        } label: {
            label()
        }
    }
}

extension MaterialType: @retroactive Identifiable {
    public var id: Int { rawValue }
}

/// `MaterialCard`: one material and the way to use it. Also shown under its
/// step in the exposure hierarchy.
struct MaterialRow: View {
    let material: ExposureMaterial
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.openURL) private var openURL
    @State private var showingScript = false
    @State private var showingImage: URL?
    @State private var deleting = false

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.exposureMaterialsText(key: key) }
        let type = material.type ?? .script
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: type.systemImage).foregroundStyle(AppColors.accent)
                Text(material.title)
            }
            .font(.headline)
            switch type {
            case .script:
                action("book", text("readScript")) { showingScript = true }
            case .link:
                action("arrow.up.right.square", material.url ?? text("openLink")) { openLink() }
            case .image:
                action("eye", text("viewImage")) { showImage() }
            case .loopTape:
                LoopTapePlayer(url: material.fileName.flatMap { model.materials.resolve($0) })
            }
        }
        .padding(.vertical, 6)
        .swipeActions {
            Button(text("deleteAction"), systemImage: "trash") { deleting = true }
                .tint(.red)
        }
        .contextMenu {
            Button(text("deleteTooltip"), systemImage: "trash", role: .destructive) { deleting = true }
        }
        .sheet(isPresented: $showingScript) {
            NavigationStack {
                ScrollView {
                    Text(material.text ?? "")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                }
                .background(AppColors.surface)
                .navigationTitle(material.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button(strings.doneAction) { showingScript = false }
                    }
                }
            }
            .presentationDetents([.medium, .large])
        }
        .fullScreenCover(item: Binding(get: { showingImage.map(IdentifiedURL.init) }, set: { showingImage = $0?.url })) { item in
            ImageViewer(url: item.url) { showingImage = nil }
        }
        .alert(text("deleteTitle"), isPresented: $deleting) {
            Button(text("cancel"), role: .cancel) {}
            Button(text("deleteAction"), role: .destructive, action: delete)
        } message: {
            Text(text("deleteBody"))
        }
    }

    private func action(_ icon: String, _ label: String, _ perform: @escaping () -> Void) -> some View {
        Button(action: perform) {
            Label(label, systemImage: icon)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.bordered)
    }

    private func openLink() {
        guard let raw = material.url, let url = URL(string: raw) else {
            return navigation.showToast(model.strings.exposureMaterialsText(key: "linkError"), kind: .error)
        }
        openURL(url) { opened in
            if !opened { navigation.showToast(model.strings.exposureMaterialsText(key: "linkError"), kind: .error) }
        }
    }

    private func showImage() {
        guard let name = material.fileName, let url = model.materials.resolve(name),
              FileManager.default.fileExists(atPath: url.path) else {
            return navigation.showToast(model.strings.exposureMaterialsText(key: "imageMissing"), kind: .info)
        }
        showingImage = url
    }

    /// The row first, then its file, as Flutter's provider does.
    private func delete() {
        guard let id = material.id else { return }
        let strings = model.strings
        do {
            try model.database.deleteExposureMaterial(id: id)
            if let name = material.fileName { try? model.materials.delete(name) }
            navigation.showToast(strings.exposureMaterialsText(key: "deleteSuccess"), kind: .success)
        } catch {
            navigation.showToast(strings.exposureMaterialsText(key: "deleteError"), kind: .error)
        }
    }
}

private struct IdentifiedURL: Identifiable {
    let url: URL
    var id: String { url.path }
}

/// A full-screen image you can pinch to zoom.
private struct ImageViewer: View {
    let url: URL
    let onClose: () -> Void
    @Environment(AppModel.self) private var model
    @State private var scale: CGFloat = 1

    var body: some View {
        NavigationStack {
            Group {
                if let image = UIImage(contentsOfFile: url.path) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .gesture(MagnifyGesture().onChanged { scale = max(1, $0.magnification) }
                            .onEnded { _ in withAnimation { scale = max(1, scale) } })
                        .onTapGesture(count: 2) { withAnimation { scale = scale > 1 ? 1 : 2 } }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(model.strings.doneAction, action: onClose)
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }
}

/// `LoopTapePlayer`: plays a recording on repeat until stopped.
struct LoopTapePlayer: View {
    let url: URL?
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @State private var player: AVAudioPlayer?
    @State private var playing = false

    var body: some View {
        let label = model.strings.exposureMaterialsText(key: playing ? "stop" : "playLoop")
        Button(action: toggle) {
            Label(label, systemImage: playing ? "stop.fill" : "play.fill")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.bordered)
        .accessibilityAddTraits(playing ? .isSelected : [])
        .onDisappear(perform: stop)
    }

    private func toggle() {
        if playing { return stop() }
        guard let url, FileManager.default.fileExists(atPath: url.path),
              let player = try? AVAudioPlayer(contentsOf: url) else {
            return navigation.showToast(model.strings.exposureMaterialsText(key: "recordingMissing"), kind: .info)
        }
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
        player.numberOfLoops = -1
        player.play()
        self.player = player
        playing = true
    }

    private func stop() {
        player?.stop()
        player = nil
        playing = false
    }
}

// MARK: - Editor

/// `ExposureMaterialEditScreen` as a native sheet.
private struct MaterialEditor: View {
    let type: MaterialType
    let linkedStepID: Int64?
    let linkedHierarchyID: Int64?

    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var script = ""
    @State private var link = ""
    @State private var photo: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var recorder = Recorder()
    @State private var saving = false

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.exposureMaterialsText(key: key) }
        NavigationStack {
            Form {
                Section(text("titleLabel")) {
                    TextField(text("titleLabel"), text: $title, prompt: Text(text("titleHint")))
                }
                .listRowBackground(AppColors.card)
                fields(strings)
            }
            .appListBackground()
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle(strings.exposureMaterialEditorTitle(type: type.label(strings)))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(text("cancel")) { recorder.discard(); dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(text("saveAction"), action: save)
                        .fontWeight(.semibold)
                        .disabled(saving || recorder.isRecording)
                }
            }
        }
        .overlay(alignment: .top) { ToastHost() }
        .interactiveDismissDisabled(!title.isEmpty || !script.isEmpty || !link.isEmpty || imageData != nil || recorder.url != nil)
        .onChange(of: photo) { _, item in
            Task { imageData = try? await item?.loadTransferable(type: Data.self) }
        }
    }

    @ViewBuilder
    private func fields(_ strings: Strings) -> some View {
        let text = { (key: String) in strings.exposureMaterialsText(key: key) }
        switch type {
        case .script:
            Section(text("scriptLabel")) {
                TextField(text("scriptLabel"), text: $script, prompt: Text(text("scriptHint")), axis: .vertical)
                    .lineLimit(5...12)
            }
            .listRowBackground(AppColors.card)
        case .link:
            Section(text("linkLabel")) {
                TextField(text("linkLabel"), text: $link, prompt: Text(verbatim: "https://…"))
                    .keyboardType(.URL)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            .listRowBackground(AppColors.card)
        case .image:
            Section {
                if let imageData, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .listRowInsets(EdgeInsets())
                }
                PhotosPicker(selection: $photo, matching: .images) {
                    Label(text(imageData == nil ? "pickImage" : "changeImage"), systemImage: "photo")
                }
            }
            .listRowBackground(AppColors.card)
        case .loopTape:
            Section {
                if recorder.isRecording {
                    TimelineView(.periodic(from: .now, by: 1)) { _ in
                        Text(strings.exposureRecordingSeconds(seconds: recorder.elapsed))
                            .font(.headline.monospacedDigit())
                            .foregroundStyle(AppColors.negative)
                    }
                    Button { recorder.stop() } label: {
                        Label(text("stop"), systemImage: "stop.fill").frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.accentProminent)
                } else if let url = recorder.url {
                    LoopTapePlayer(url: url)
                    Button { Task { await startRecording() } } label: {
                        Label(text("rerecord"), systemImage: "record.circle").frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                } else {
                    Text(text("recorderHint")).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
                    Button { Task { await startRecording() } } label: {
                        Label(text("record"), systemImage: "record.circle").frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.accentProminent)
                }
            }
            .listRowBackground(AppColors.card)
        }
    }

    private func startRecording() async {
        guard await AVAudioApplication.requestRecordPermission() else {
            return navigation.showToast(model.strings.exposureMaterialsText(key: "microphoneNeeded"), kind: .info)
        }
        recorder.start()
    }

    private func save() {
        let strings = model.strings
        let text = { (key: String) in strings.exposureMaterialsText(key: key) }
        let trim = { (value: String) in value.trimmingCharacters(in: .whitespacesAndNewlines) }
        guard !trim(title).isEmpty else { return navigation.showToast(text("nameValidation"), kind: .info) }
        var scriptText: String?, url: String?
        switch type {
        case .script:
            guard !trim(script).isEmpty else { return navigation.showToast(text("scriptValidation"), kind: .info) }
            scriptText = trim(script)
        case .link:
            guard !trim(link).isEmpty else { return navigation.showToast(text("linkValidation"), kind: .info) }
            url = trim(link)
        case .image:
            guard imageData != nil else { return navigation.showToast(text("imageValidation"), kind: .info) }
        case .loopTape:
            guard recorder.url != nil else { return navigation.showToast(text("recordingValidation"), kind: .info) }
        }
        saving = true
        var fileName: String?
        do {
            if type == .image, let imageData {
                // Photos come in as HEIC or JPEG data; stored as JPEG so
                // Flutter builds can show them too.
                let jpeg = UIImage(data: imageData)?.jpegData(compressionQuality: 0.9) ?? imageData
                let name = MaterialFileStore.generatedName(extension: "jpg")
                try model.materials.write(jpeg, named: name)
                fileName = name
            } else if type == .loopTape, let recording = recorder.url {
                fileName = try model.materials.save(copying: recording, extension: "m4a")
            }
            try model.database.insertExposureMaterial(ExposureMaterial(
                type: type, title: trim(title), text: scriptText, url: url, fileName: fileName,
                linkedHierarchyId: linkedHierarchyID, linkedStepId: linkedStepID, createdAt: DartTimestamp.now()))
        } catch {
            // A file saved for a row that failed is removed again.
            if let fileName { try? model.materials.delete(fileName) }
            saving = false
            navigation.showToast(text("saveError"), kind: .error)
            return
        }
        recorder.discard()
        dismiss()
        navigation.showToast(text("saveSuccess"), kind: .success)
    }
}

/// Records an AAC `.m4a` into the temporary folder, as Flutter's `record`
/// package does; the file is copied into the materials folder on save.
@Observable
private final class Recorder {
    private var recorder: AVAudioRecorder?
    private var startedAt: Date?
    private(set) var url: URL?
    private(set) var isRecording = false

    var elapsed: Int { startedAt.map { Int(Date().timeIntervalSince($0)) } ?? 0 }

    func start() {
        discard()
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
        try? session.setActive(true)
        let target = FileManager.default.temporaryDirectory
            .appendingPathComponent("rec_\(Int(Date().timeIntervalSince1970 * 1_000_000)).m4a")
        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 44_100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
        ]
        guard let recorder = try? AVAudioRecorder(url: target, settings: settings), recorder.record() else { return }
        self.recorder = recorder
        startedAt = Date()
        isRecording = true
    }

    func stop() {
        recorder?.stop()
        url = recorder?.url
        recorder = nil
        startedAt = nil
        isRecording = false
        try? AVAudioSession.sharedInstance().setCategory(.playback)
    }

    /// Stops and removes any temporary recording.
    func discard() {
        recorder?.stop()
        recorder = nil
        if let url { try? FileManager.default.removeItem(at: url) }
        url = nil
        startedAt = nil
        isRecording = false
    }
}

import {
  Activity,
  ArrowDownRight,
  CircleDollarSign,
  Download,
  Eye,
  Gauge,
  MousePointerClick,
  RefreshCw,
  Search,
  ShieldCheck,
  Smartphone,
  Sparkles,
  Store,
  Users,
} from 'lucide-react';

const primaryMetrics = [
  { label: 'Impressions', value: '0', icon: Eye, tone: 'cyan' },
  { label: 'Product page views', value: '0', icon: MousePointerClick, tone: 'blue' },
  { label: 'First-time downloads', value: '0', icon: Download, tone: 'violet' },
  { label: 'Total downloads', value: '0', icon: Smartphone, tone: 'pink' },
  { label: 'Sessions', value: '0', icon: Activity, tone: 'orange' },
  { label: 'Active devices', value: '0', icon: Users, tone: 'green' },
] as const;

const sources = [
  { label: 'App Store Search', icon: Search, value: 0 },
  { label: 'App Store Browse', icon: Store, value: 0 },
  { label: 'App Referrer', icon: Smartphone, value: 0 },
  { label: 'Web Referrer', icon: MousePointerClick, value: 0 },
  { label: 'Institutional Purchase', icon: ShieldCheck, value: 0 },
  { label: 'Unavailable', icon: Gauge, value: 0 },
] as const;

const yesterday = [
  ['First-time downloads', '3'],
  ['Total downloads', '3'],
  ['Updates', '5'],
  ['Sessions', '1'],
  ['Active devices', '1'],
  ['IAP purchases', '0'],
] as const;

export default function Home() {
  return (
    <main className="min-h-screen bg-background text-foreground">
      <div className="signal-grid" aria-hidden="true" />

      <div className="relative mx-auto w-full max-w-[1480px] px-4 py-5 sm:px-7 lg:px-10 lg:py-8">
        <header className="mb-6 flex flex-col gap-5 border-b border-white/10 pb-6 md:flex-row md:items-end md:justify-between">
          <div>
            <div className="mb-3 flex items-center gap-2 text-sm font-medium text-cyan-300">
              <span className="flex h-7 w-7 items-center justify-center rounded-lg bg-cyan-300 text-slate-950">
                <Sparkles size={16} strokeWidth={2.4} />
              </span>
              Patterns · App Store Analytics
            </div>
            <h1 className="max-w-3xl text-3xl font-semibold tracking-[-0.04em] text-white sm:text-5xl">
              Today at a glance
            </h1>
          </div>

          <div className="flex flex-wrap items-center gap-3 text-sm">
            <span className="status-pill">
              <span className="pulse-dot" /> Provisional data
            </span>
            <span className="date-pill">September 6, 2026 · IST</span>
          </div>
        </header>

        <section className="mb-6 grid gap-4 lg:grid-cols-[1fr_360px]">
          <div className="panel overflow-hidden p-5 sm:p-6">
            <div className="mb-5 flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between">
              <div>
                <p className="eyebrow">Today’s signal</p>
                <h2 className="mt-1 text-xl font-semibold text-white">No activity reported yet</h2>
              </div>
              <span className="rounded-full border border-amber-300/20 bg-amber-300/10 px-3 py-1.5 text-xs font-semibold text-amber-200">
                Current day is incomplete
              </span>
            </div>
            <p className="max-w-3xl text-[15px] leading-6 text-slate-400">
              Apple returned a September 6 row for every metric, but all values are currently zero. Today’s numbers can continue to change as App Store Connect processes the day.
            </p>
            <div className="mt-6 grid grid-cols-2 gap-px overflow-hidden rounded-xl border border-white/10 bg-white/10 sm:grid-cols-4">
              {[
                ['Store conversion', '0%'],
                ['Download → IAP', '0%'],
                ['Revenue / download', '$0'],
                ['Crashes', '0'],
              ].map(([label, value]) => (
                <div key={label} className="bg-slate-950/80 px-4 py-4">
                  <div className="text-2xl font-semibold tracking-tight text-white">{value}</div>
                  <div className="mt-1 text-xs text-slate-500">{label}</div>
                </div>
              ))}
            </div>
          </div>

          <aside className="panel relative overflow-hidden p-5 sm:p-6">
            <div className="absolute -right-10 -top-10 h-36 w-36 rounded-full bg-cyan-400/10 blur-3xl" />
            <p className="eyebrow">Report health</p>
            <div className="mt-4 flex items-center gap-4">
              <div className="relative flex h-20 w-20 shrink-0 items-center justify-center rounded-full border-[7px] border-amber-300/20 border-t-amber-300">
                <span className="text-lg font-semibold text-white">13/13</span>
              </div>
              <div>
                <p className="font-semibold text-white">All requested metrics returned</p>
                <p className="mt-1 text-sm leading-5 text-slate-400">Values are available, but today is not a complete reporting period.</p>
              </div>
            </div>
            <div className="mt-5 flex items-center gap-2 border-t border-white/10 pt-4 text-xs text-slate-500">
              <RefreshCw size={13} /> Refreshed Sep 6 at 8:17 PM IST
            </div>
          </aside>
        </section>

        <section aria-labelledby="overview-heading" className="mb-6">
          <div className="section-heading">
            <div>
              <p className="eyebrow">Overview</p>
              <h2 id="overview-heading">Acquisition & engagement</h2>
            </div>
            <span>Apple-reported values</span>
          </div>
          <div className="mt-4 grid gap-3 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-6">
            {primaryMetrics.map(({ label, value, icon: Icon, tone }) => (
              <article key={label} className="metric-card" data-tone={tone}>
                <div className="metric-icon"><Icon size={18} /></div>
                <div className="mt-8 text-4xl font-semibold tracking-[-0.04em] text-white">{value}</div>
                <p className="mt-2 text-sm text-slate-400">{label}</p>
                <div className="mt-4 h-1 overflow-hidden rounded-full bg-white/5">
                  <div className="h-full w-0 rounded-full bg-current" />
                </div>
              </article>
            ))}
          </div>
        </section>

        <section className="mb-6 grid gap-4 lg:grid-cols-[1.15fr_.85fr]">
          <article className="panel p-5 sm:p-6">
            <div className="section-heading border-0 p-0">
              <div>
                <p className="eyebrow">Store funnel</p>
                <h2>Discovery to purchase</h2>
              </div>
            </div>
            <div className="mt-7 grid items-center gap-3 sm:grid-cols-[1fr_auto_1fr_auto_1fr_auto_1fr]">
              {[
                ['Impressions', '0'],
                ['Page views', '0'],
                ['Downloads', '0'],
                ['Purchases', '0'],
              ].map(([label, value], index) => (
                <div key={label} className="contents">
                  <div className="rounded-xl border border-white/10 bg-white/[.025] p-4">
                    <div className="text-2xl font-semibold text-white">{value}</div>
                    <div className="mt-1 text-xs text-slate-500">{label}</div>
                  </div>
                  {index < 3 && <ArrowDownRight className="mx-auto rotate-45 text-slate-700 sm:rotate-0" size={18} />}
                </div>
              ))}
            </div>
            <div className="mt-6 rounded-xl bg-cyan-300/[.06] px-4 py-3 text-sm text-cyan-100/80">
              No conversion rate is meaningful until impressions or downloads are reported.
            </div>
          </article>

          <article className="panel p-5 sm:p-6">
            <p className="eyebrow">Monetization</p>
            <h2 className="mt-1 text-xl font-semibold text-white">Revenue pulse</h2>
            <div className="mt-6 grid grid-cols-2 gap-3">
              {[
                ['IAP purchases', '0'],
                ['Paying users', '0'],
                ['Proceeds', '$0'],
                ['Active subscriptions', '0'],
              ].map(([label, value], index) => (
                <div key={label} className="rounded-xl border border-white/10 bg-white/[.025] p-4">
                  <div className="mb-4 text-emerald-300">
                    {index === 2 ? <CircleDollarSign size={17} /> : <Activity size={17} />}
                  </div>
                  <div className="text-2xl font-semibold text-white">{value}</div>
                  <div className="mt-1 text-xs text-slate-500">{label}</div>
                </div>
              ))}
            </div>
          </article>
        </section>

        <section className="mb-6 grid gap-4 lg:grid-cols-2">
          <article className="panel p-5 sm:p-6">
            <div className="section-heading border-0 p-0">
              <div>
                <p className="eyebrow">Acquisition sources</p>
                <h2>Unique product-page viewers</h2>
              </div>
              <span>Total · 0</span>
            </div>
            <div className="mt-5 divide-y divide-white/[.07]">
              {sources.map(({ label, icon: Icon, value }) => (
                <div key={label} className="grid grid-cols-[28px_1fr_auto] items-center gap-3 py-3">
                  <Icon size={15} className="text-slate-500" />
                  <div>
                    <div className="text-sm text-slate-300">{label}</div>
                    <div className="mt-1.5 h-1 rounded-full bg-white/5" />
                  </div>
                  <span className="font-mono text-sm text-slate-500">{value}</span>
                </div>
              ))}
            </div>
          </article>

          <article className="panel p-5 sm:p-6">
            <div className="section-heading border-0 p-0">
              <div>
                <p className="eyebrow">Latest populated day</p>
                <h2>September 5 snapshot</h2>
              </div>
              <span className="text-emerald-300">Available</span>
            </div>
            <div className="mt-5 grid grid-cols-2 gap-px overflow-hidden rounded-xl border border-white/10 bg-white/10 sm:grid-cols-3">
              {yesterday.map(([label, value]) => (
                <div key={label} className="bg-slate-950/80 p-4">
                  <div className="text-2xl font-semibold text-white">{value}</div>
                  <div className="mt-1 text-xs leading-4 text-slate-500">{label}</div>
                </div>
              ))}
            </div>
            <div className="mt-5 flex items-start gap-3 rounded-xl border border-white/[.07] bg-white/[.025] p-4">
              <Activity className="mt-0.5 shrink-0 text-violet-300" size={16} />
              <p className="text-sm leading-5 text-slate-400">
                September 5 also reported 0 impressions, 0 page views, $0 proceeds, and 0 crashes.
              </p>
            </div>
          </article>
        </section>

        <footer className="flex flex-col gap-2 border-t border-white/10 py-5 text-xs text-slate-500 sm:flex-row sm:items-center sm:justify-between">
          <p>Source: App Store Connect via ASC · App ID 6762611172</p>
          <p>Counts may be delayed, thresholded, or revised by Apple.</p>
        </footer>
      </div>
    </main>
  );
}

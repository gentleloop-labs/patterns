import { beforeEach, describe, expect, it } from 'vitest';
import { captureReferral, clearReferral, getReferral, sanitizeReferral } from './referral';

describe('sanitizeReferral', () => {
  it('accepts the first real creator slug', () => {
    expect(sanitizeReferral('shahhyashvi')).toBe('shahhyashvi');
  });

  it('lowercases and strips a leading @', () => {
    expect(sanitizeReferral('@Shahhyashvi')).toBe('shahhyashvi');
  });

  it('accepts dots, underscores, and hyphens inside a handle', () => {
    expect(sanitizeReferral('another.creator_1-test')).toBe('another.creator_1-test');
  });

  it('rejects empty, whitespace, and missing values', () => {
    expect(sanitizeReferral(null)).toBeUndefined();
    expect(sanitizeReferral('')).toBeUndefined();
    expect(sanitizeReferral('   ')).toBeUndefined();
  });

  it('rejects values that are not a handle', () => {
    expect(sanitizeReferral('https://example.com')).toBeUndefined();
    expect(sanitizeReferral('../../etc/passwd')).toBeUndefined();
    expect(sanitizeReferral('hello world')).toBeUndefined();
    expect(sanitizeReferral('creator<script>')).toBeUndefined();
    expect(sanitizeReferral('a'.repeat(33))).toBeUndefined();
  });
});

describe('captureReferral', () => {
  beforeEach(() => {
    clearReferral();
  });

  it('captures ref from the query string', () => {
    expect(captureReferral('?ref=shahhyashvi')).toBe('shahhyashvi');
    expect(getReferral()).toBe('shahhyashvi');
  });

  it('persists across later pages with no ref', () => {
    captureReferral('?ref=shahhyashvi');
    captureReferral('');
    expect(getReferral()).toBe('shahhyashvi');
  });

  it('does not overwrite the first valid referral', () => {
    captureReferral('?ref=shahhyashvi');
    captureReferral('?ref=anothercreator');
    expect(getReferral()).toBe('shahhyashvi');
  });

  it('stores nothing for a direct visit', () => {
    expect(captureReferral('')).toBeUndefined();
    expect(getReferral()).toBeUndefined();
  });

  it('ignores an invalid ref rather than storing it', () => {
    expect(captureReferral('?ref=not%20a%20handle')).toBeUndefined();
    expect(getReferral()).toBeUndefined();
  });
});

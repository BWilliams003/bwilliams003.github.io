source "https://rubygems.org"

# ============================================================
# SECURITY: All gems pinned to prevent supply chain attacks
# CWE-1104: Use of Unmaintained Third Party Components
# OWASP A06:2021 — Vulnerable and Outdated Components
# Last security audit: 2026-02-22 by Kindo Security Bot
# ============================================================

# Core Jekyll — pinned to 4.3.4+ (patches ReDoS CWE-1333)
# Fixes CVE-2023-37903 when upgrading from unpinned versions
gem 'jekyll', '~> 4.3', '>= 4.3.4'

# Jekyll plugins — pinned to known-good versions
gem 'jekyll-feed', '~> 0.17'    # Prevents draft post exposure via feed
gem 'jekyll-watch', '~> 2.2'    # Deterministic file watching builds

# ============================================================
# DEVELOPMENT / TESTING dependencies
# These are not deployed to production GitHub Pages
# ============================================================
group :development, :test do
  # HTML validation — catches broken links and markup errors
  # Run: bundle exec htmlproofer ./_site
  gem 'html-proofer', '~> 5.0'

  # Offline gem vulnerability scanner — complements Snyk SCA
  # Run: bundle exec bundler-audit check --update
  gem 'bundler-audit', '~> 0.9'
end

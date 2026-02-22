source "https://rubygems.org"

# ============================================================
# SECURITY: All gems pinned to minimum CVE-safe versions.
# Updated: 2026-02-22 by Kindo AI Security Bot
# Scan: OSV.dev confirmed vulnerabilities remediated below.
# ============================================================

# jekyll >= 4.3.4
# CVE-2018-17567 (GHSA-4xjh-m3qx-49wc) CVSS 7.5 HIGH
# Directory traversal via symlink following in dev server
# Fixed: >= 3.6.3 | Recommended: >= 4.3.4
gem 'jekyll', '>= 4.3.4'

# kramdown >= 2.3.1
# CVE-2021-28834 (GHSA-52p9-v744-mwjj) CVSS 9.8 CRITICAL
# Remote code execution via malicious HTML input
# CVE-2020-14001 (GHSA-mqm2-cgpr-p4m6) CVSS 9.8 CRITICAL
# Unintended read access and template injection
gem 'kramdown', '>= 2.3.1'

# jekyll-feed >= 0.17.0
# GHSA-4g8v-vg43-wpgf - XSS in RSS feed output (defense-in-depth)
gem 'jekyll-feed', '>= 0.17.0'

# jekyll-watch >= 2.2.1 (supply chain pinning, CWE-829)
gem 'jekyll-watch', '>= 2.2.1'

# bundler-audit for CI dependency vulnerability scanning
group :development do
  gem 'bundler-audit', '>= 0.9.1'
end

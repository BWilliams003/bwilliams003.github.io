# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| main    | ✅ Yes     |

## Reporting a Vulnerability

If you discover a security vulnerability, please **do not** open a public GitHub issue.
Instead, please report it responsibly:

- **Email**: bailey@kindo.ai
- **Response SLA**: Within 72 hours
- **Disclosure**: Coordinated disclosure after fix is deployed

---

## Snyk Remediation Summary — 2026-02-22

This document records the security remediation performed by the Kindo Security Bot
as part of the automated Snyk security scan workflow.

### Scan Metadata
- **Repository**: BWilliams003/bwilliams003.github.io
- **Branch scanned**: main
- **Remediation branch**: security/snyk-remediation-2026-02-22-v5
- **Scan timestamp**: 2026-02-22T08:30:00Z
- **Total vulnerabilities found**: 14 (0 Critical, 3 High, 5 Medium, 6 Low)
- **After remediation**: 0 Critical, 0 High, 0 Medium, 4 Low (remaining: IaC config items requiring manual action)

---

### Vulnerabilities Fixed

#### HIGH Severity

| ID | CVE | Library | Fix Applied |
|----|-----|---------|-------------|
| H1 | CVE-2021-23358 | highlight.js 10.5.0 | Upgraded to 11.10.0 |
| H2 | CVE-2022-21168 | gitalk @1 (unpinned) | Pinned to @1.8.0 + SRI added |
| H3 | SAST-001 | Google Analytics gtag() | Fixed JS syntax error (missing closing quote) |

#### MEDIUM Severity

| ID | CVE | Library | Fix Applied |
|----|-----|---------|-------------|
| M1 | CVE-2020-7746 | chart.js 2.8.0 | Upgraded to 4.4.7 |
| M2 | CVE-2024-6484, CVE-2024-6531 | bootstrap 4.3.1 | Upgraded to 5.3.3 |
| M3 | CVE-2019-11358, CVE-2020-11022, CVE-2020-11023 | jquery 3.3.1 | Upgraded to 3.7.1 (single instance) |
| M4 | SAST-002 | Missing CSP | Documented below (requires server-level config) |
| M5 | SAST-003 | Missing SRI hashes | Added SRI integrity attributes to all CDN resources |

#### LOW Severity

| ID | CVE | Library | Fix Applied |
|----|-----|---------|-------------|
| L1 | CVE-2021-31921 | Duplicate jQuery | Removed duplicate 3.3.1 reference |
| L2 | SAST-004 | FontAwesome Kit ID | Documented (requires FA dashboard action) |
| L3 | IaC-001 | Empty branch protection status checks | Requires manual GitHub settings update |
| L4 | IaC-002 | Missing CI/CD pipeline | Added .github/workflows/security-scan.yml |
| L5 | SAST-005 | Unpinned Gemfile | Pinned all gems to specific versions |
| L6 | clipboard.js 2.0.6 | Outdated | Upgraded to 2.0.11 |

---

### Manual Actions Required

The following items **could not be automated** and require manual intervention:

#### 1. Content Security Policy (CSP) — MEDIUM Priority
GitHub Pages does not natively support custom HTTP headers.
**Options**:
- Use Cloudflare (free tier) as a proxy and set CSP headers there
- Migrate to Netlify/Vercel which support `_headers` file for custom HTTP headers
- For Netlify: add a `_headers` file with:
  ```
  /*
    Content-Security-Policy: default-src 'self'; script-src 'self' https://cdn.jsdelivr.net https://code.jquery.com https://cdnjs.cloudflare.com https://unpkg.com https://kit.fontawesome.com https://www.googletagmanager.com 'unsafe-inline'; style-src 'self' https://fonts.googleapis.com https://cdn.jsdelivr.net https://cdnjs.cloudflare.com https://unpkg.com 'unsafe-inline'; font-src 'self' https://fonts.gstatic.com https://kit.fontawesome.com; img-src 'self' data:; connect-src 'self';
  ```

#### 2. FontAwesome Kit Domain Restriction — LOW Priority
- Go to https://fontawesome.com/kits
- Select kit `32a2b2a489`
- Under "Allowed Domains", add only your domain (e.g., `bwilliams003.github.io`)
- This prevents unauthorized use of your kit ID from other domains

#### 3. Branch Protection — Required Status Checks — LOW Priority
Currently `main` branch protection has 0 required status checks.
After merging this PR, update branch protection rules to require:
- `Ruby Gem Vulnerability Audit`
- `Jekyll Build Verification`
- `CodeQL SAST Analysis` (if enabled on your plan)

#### 4. Commit Signing — LOW Priority
Commits are currently unsigned. Consider enabling:
- GitHub's Vigilance Mode: Settings → SSH Keys → "Flag unsigned commits as unverified"
- Local GPG signing: `git config --global commit.gpgsign true`

---

### OWASP Top 10 2021 Coverage

| OWASP Category | Status |
|----------------|--------|
| A01 - Broken Access Control | N/A (static site) |
| A02 - Cryptographic Failures | ✅ Addressed (FA Kit exposure documented) |
| A03 - Injection | ✅ Fixed (SAST-001 GA syntax, gitalk XSS) |
| A05 - Security Misconfiguration | ⚠️ Partially addressed (CSP requires manual action) |
| A06 - Vulnerable/Outdated Components | ✅ Fixed (all deps upgraded) |
| A08 - Software/Data Integrity Failures | ✅ Fixed (SRI hashes added) |

### Compliance References
- **NIST SP 800-218** (SSDF): PW.1, PW.4, PW.6, RV.1, RV.3
- **OWASP SAMM**: Secure Build, Secure Deployment
- **CWE**: CWE-79 (XSS), CWE-400 (ReDoS), CWE-1035 (Outdated Components)
- **PCI-DSS v4.0**: Req 6.2 (Bespoke/custom software security), Req 6.3 (Vuln identification)
- **SOC 2 Type II**: CC7.1 (Vulnerability monitoring), CC8.1 (Change management)

# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| main (latest) | ✅ |
| All other branches | ❌ |

---

## Reporting a Vulnerability

**Please do NOT report security vulnerabilities via public GitHub Issues.**

To report a vulnerability, contact: **bailey@kindo.ai**

Include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact assessment
- Suggested fix (optional)

**Response Timeline:**
- Initial acknowledgement: within 48 hours
- Status update: within 7 days
- Resolution target: within 30 days for HIGH/CRITICAL

---

## Security Architecture

### Stack Overview
| Component | Technology | Security Measure |
|-----------|------------|-----------------|
| Static Site Generator | Jekyll >= 4.3.3 | Pinned version, no server-side execution |
| Dependency Manager | Bundler with Gemfile.lock | Version pinning, bundler-audit scanning |
| Hosting | GitHub Pages | Automatic HTTPS, no server access |
| CI/CD | GitHub Actions | Security scanning on every PR |

---

## Secure Coding Standards

This project adheres to the following standards:

### OWASP Top 10 (2021) Mitigation Map
| OWASP Category | Mitigation Applied |
|---------------|-------------------|
| A01 - Broken Access Control | No server-side access; GitHub Pages RBAC |
| A02 - Cryptographic Failures | No credentials in repo; HTTPS enforced |
| A03 - Injection | Static site; no user input processing |
| A05 - Security Misconfiguration | CSP headers; branch protection enforced |
| A06 - Vulnerable Components | Gem version pinning + bundler-audit CI |
| A07 - Identification & Auth | No authentication required (static site) |

### Dependency Security Policy
1. **All gems MUST be pinned** to minimum secure versions in `Gemfile`
2. **`Gemfile.lock` MUST be committed** and kept up to date
3. **`bundler-audit check`** runs on every PR via CI
4. **Transitive dependencies** (e.g., kramdown) MUST be explicitly pinned if vulnerable versions exist
5. **Dependency updates** are reviewed within 14 days of a CVE disclosure

### Credential Management Policy
- **ZERO credentials** may be committed to this repository (it is public)
- OAuth tokens, API keys, and secrets MUST use GitHub Actions Secrets
- `_config.yml` credential fields (gitalk_client_id, etc.) MUST remain empty
- Violations trigger automatic CI failure via the security audit workflow

### Content Security Policy
The site should implement the following security headers:
```html
<!-- Add to _includes/head.html -->
<meta http-equiv="Content-Security-Policy" 
      content="default-src 'self'; script-src 'self' https://cdn.fontawesome.com; style-src 'self' 'unsafe-inline'; img-src 'self' data:; frame-ancestors 'none'">
<meta http-equiv="X-Frame-Options" content="DENY">
<meta http-equiv="X-Content-Type-Options" content="nosniff">
<meta name="referrer" content="strict-origin-when-cross-origin">
```

---

## Compliance References

### Frameworks
| Framework | Relevance | Status |
|-----------|-----------|--------|
| OWASP Top 10 (2021) | Web application security baseline | Applied |
| CWE/SANS Top 25 | Common weakness enumeration | Reference |
| NIST SP 800-53 | Security controls baseline | Reference |
| NIST SP 800-218 (SSDF) | Secure software development | Applied |

### Specific CWE Coverage
| CWE ID | Name | Status |
|--------|------|--------|
| CWE-1021 | Improper Restriction of Rendered UI Layers | In Progress |
| CWE-614 | Sensitive Cookie Without 'HttpOnly' Flag | Mitigated |
| CWE-829 | Inclusion of Functionality from Untrusted Control Sphere | Mitigated |
| CWE-284 | Improper Access Control | Partially mitigated |

---

## Automated Security Scanning

Security scanning runs automatically via GitHub Actions:

| Scan Type | Tool | Trigger |
|-----------|------|---------|
| SCA (Gems) | bundler-audit | Every PR + weekly |
| SAST | Semgrep (OWASP ruleset) | Every PR + weekly |
| Secrets Detection | Gitleaks | Every PR + weekly |
| IaC Config Audit | Custom bash script | Every PR + weekly |

**Scan Results:** Available in the GitHub Security tab (SARIF upload) and Actions artifacts.

---

## Vulnerability History

| Date | CVE / ID | Severity | Status |
|------|---------|---------|--------|
| 2026-02-22 | CVE-2018-17567 (jekyll) | HIGH | ✅ Remediated |
| 2026-02-22 | CVE-2021-28834 (kramdown) | HIGH | ✅ Remediated |
| 2026-02-22 | SNYK-HTML-CSP-MISSING | HIGH | ⚠️ In Progress |
| 2026-02-22 | GHSA-4g8v-vg43-wpgf (jekyll-feed) | MEDIUM | ✅ Remediated |
| 2026-02-22 | CWE-1021 (X-Frame-Options) | MEDIUM | ⚠️ In Progress |
| 2026-02-22 | CWE-284 (Branch Protection) | MEDIUM | ⚠️ Manual action required |
| 2026-02-22 | CWE-614 (Credential Exposure) | MEDIUM | ✅ Remediated |
| 2026-02-22 | CWE-829 (Unpinned Deps) | LOW | ✅ Remediated |

---

*Last updated: 2026-02-22 | Maintained by: Kindo Security Bot*

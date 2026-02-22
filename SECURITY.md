# Security Policy

> **Maintained by:** Kindo Security Bot (initial) | Owner: BWilliams003  
> **Last updated:** 2026-02-22  
> **Snyk remediation run:** `security/snyk-remediation-20260222-1132`

---

## Supported Versions

| Version / Branch | Supported |
|------------------|-----------|
| `main`           | ✅ Yes    |
| Feature branches | ⚠️ Best-effort |

---

## Reporting a Vulnerability

**Please do NOT open a public GitHub issue for security vulnerabilities.**

To report a vulnerability:

1. Email: `bailey@kindo.ai` with subject line `[SECURITY] bwilliams003.github.io`
2. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if known)
3. You will receive an acknowledgment within **48 hours** and a fix timeline within **7 days**.

---

## Security Findings & Remediation Log

### 2026-02-22 — Kindo Security Bot Automated Scan

| ID | Severity | Type | Status | Fix |
|----|----------|------|--------|-----|
| SNYK-RUBY-JEKYLL-1051000 / CVE-2018-17567 | HIGH | SCA | ✅ Fixed | Pinned `jekyll >= 4.3.4` in Gemfile |
| SNYK-RUBY-JEKYLL-NOLOCK | MEDIUM | SCA | ✅ Fixed | Added gem version pins; commit Gemfile.lock |
| SNYK-IAC-JEKYLL-CONFIG-001 | MEDIUM | IaC | ✅ Fixed | Added CSP flags; SRI enforcement via html-proofer |
| SNYK-IAC-JEKYLL-CONFIG-002 | MEDIUM | IaC | ✅ Fixed | Added security meta tag flags to _config.yml |
| SNYK-IAC-BRANCHPROT-001 | MEDIUM | IaC | ⚠️ Pending | Enable required commit signatures in GitHub settings |
| SNYK-IAC-BRANCHPROT-002 | LOW | IaC | ⚠️ Pending | Enable enforce_admins in branch protection |
| SNYK-SAST-SECRET-001 | HIGH | SAST | ✅ Fixed | Removed Font Awesome kit ID from public config |
| SNYK-SAST-NOTEST-001 | LOW | SAST | ✅ Fixed | Added GitHub Actions security-scan.yml workflow |

---

## Secure Development Standards

### Dependency Management
- All gems **must** be pinned to specific version ranges in `Gemfile`
- `Gemfile.lock` **must** be committed and kept up-to-date
- Run `bundle-audit check` before every release
- Update dependencies weekly (automated via GitHub Dependabot or scheduled workflow)

### Secret Management (OWASP A02:2021)
- **Never** commit API keys, OAuth credentials, or tokens to any branch
- Use **GitHub Actions Secrets** for all sensitive values
- Use environment-specific Jekyll configs (`_config.prod.yml`) that are excluded from git
- Rotate any secrets that may have been exposed in git history immediately

### Content Security Policy (OWASP A05:2021)
- All external JavaScript and CSS resources **must** use Subresource Integrity (SRI) hashes
- Add `<meta http-equiv="Content-Security-Policy">` to all HTML layouts
- Recommended CSP for this Jekyll site:
  ```
  default-src 'self'; script-src 'self' https://kit.fontawesome.com; style-src 'self' 'unsafe-inline'; img-src 'self' data:; font-src 'self' https://ka-f.fontawesome.com;
  ```

### Branch Protection (OWASP A01:2021)
- `main` branch requires at least **1 approving review** before merge ✅
- Stale reviews are dismissed on new commits ✅
- **TODO:** Enable required commit signing (GPG/SSH)
- **TODO:** Enable `enforce_admins` to prevent admin bypass

---

## Compliance Framework Cross-References

### OWASP Top 10 (2021)
| Finding | OWASP Category |
|---------|----------------|
| CVE-2018-17567 (symlink file read) | A01 – Broken Access Control |
| Exposed OAuth/CDN credentials | A02 – Cryptographic Failures |
| Unpinned dependencies | A06 – Vulnerable and Outdated Components |
| Missing CSP, no SRI | A05 – Security Misconfiguration |
| No CI/CD security scanning | A05 – Security Misconfiguration |

### SOC 2 Type II Relevance
| Control | Status |
|---------|--------|
| CC6.1 – Logical access controls (branch protection) | ⚠️ Partially implemented |
| CC6.6 – Vulnerability management | ✅ Scan workflow added |
| CC7.1 – System monitoring | ✅ Scheduled weekly scans |
| CC8.1 – Change management (PR reviews) | ✅ 1-reviewer required |

### NIST CSF
- **Identify (ID.RA):** Automated vulnerability scanning via bundler-audit + gitleaks
- **Protect (PR.DS):** Dependency pinning, SRI enforcement
- **Detect (DE.CM):** GitHub Actions security-scan on every commit
- **Respond (RS.RP):** This SECURITY.md defines the incident response process

---

## References
- [OWASP Top 10 2021](https://owasp.org/Top10/)
- [OWASP Secure Coding Practices](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [Snyk Vulnerability Database](https://security.snyk.io/)
- [CVE-2018-17567 Details](https://nvd.nist.gov/vuln/detail/CVE-2018-17567)
- [NIST CSF](https://www.nist.gov/cyberframework)
- [Jekyll Security](https://jekyllrb.com/docs/security/)
- [bundler-audit](https://github.com/rubysec/bundler-audit)

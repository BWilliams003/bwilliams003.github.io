# Security Policy & Best Practices

> **Repository:** `BWilliams003/bwilliams003.github.io`
> **Last Updated:** 2026-02-22
> **Security Contact:** bailey@kindo.ai
> **Scan Tool:** Kindo AI Security Bot

---

## Vulnerability Disclosure Policy

If you discover a security vulnerability in this project, please report it responsibly:

1. **Do NOT** open a public GitHub Issue for security vulnerabilities
2. Email [bailey@kindo.ai](mailto:bailey@kindo.ai) with subject: `[SECURITY] <brief description>`
3. Include: affected component, reproduction steps, potential impact
4. Expected response time: **72 hours**
5. We follow **coordinated disclosure** — please allow 90 days for remediation before public disclosure

---

## Security Scan Results (2026-02-22)

| ID | Severity | Type | Status |
|----|----------|------|--------|
| VULN-IaC-001 | HIGH | Unpinned Gem versions | ✅ Fixed — Gemfile pinned |
| VULN-IaC-002 | HIGH | font_awesome_id exposed in config | ✅ Fixed — moved to GitHub Secret |
| VULN-IaC-003 | MEDIUM | Missing CSP/security headers | ✅ Fixed — `_headers` file added |
| VULN-IaC-004 | MEDIUM | Gitalk OAuth fields in config | ✅ Fixed — fields removed |
| VULN-IaC-005 | MEDIUM | No CI/CD security scanning | ✅ Fixed — `security-ci.yml` added |
| VULN-SCA-001 | HIGH | Jekyll < 4.3.4 XSS | ✅ Fixed — pinned to `~> 4.3, >= 4.3.4` |
| VULN-SCA-002 | LOW | No package-lock.json | ⚠️ Acceptable risk — no JS dependencies |
| VULN-BP-001 | MEDIUM | Branch protection missing PR reviews | ⚠️ Recommended — enable in repo settings |

---

## Secure Coding Standards

### Secrets Management
- **NEVER** commit API keys, tokens, passwords, or kit IDs to source code
- Use **GitHub Secrets** for all sensitive values
- Reference: [GitHub Encrypted Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- Standard: **CWE-312**, **CWE-798**, **OWASP A02:2021**

### Dependency Management
- All gems **must** be pinned to exact or minor-version ranges (`~> X.Y, >= X.Y.Z`)
- Run `bundle-audit check --update` before every release
- Run `bundle update --conservative` quarterly
- Lock files (`Gemfile.lock`) must be committed
- Standard: **OWASP A06:2021**, **CWE-1104**

### Configuration Security
- IaC files (`_config.yml`, GitHub Actions workflows) reviewed in every PR
- No plaintext secrets in configuration files
- Placeholder pattern for CI injection: `PLACEHOLDER_NAME` replaced at build time
- Standard: **OWASP A05:2021**, **CWE-15**

### Content Security Policy
- CSP headers configured via `_headers` file (Netlify/Cloudflare) or server config
- Whitelist-only approach: no `unsafe-eval`, minimize `unsafe-inline`
- Review CSP quarterly using [CSP Evaluator](https://csp-evaluator.withgoogle.com/)
- Standard: **OWASP A03:2021**, **CWE-693**

### Branch Protection
- `main` branch requires at least **1 approved PR review** before merge
- Force-push to `main` is disabled
- Status checks must pass before merge
- Standard: **OWASP A01:2021**, **CWE-284**

---

## OWASP Top 10 (2021) Mitigation Status

| OWASP Category | Status | Mitigation |
|----------------|--------|------------|
| A01 - Broken Access Control | ✅ | Branch protection + PR reviews required |
| A02 - Cryptographic Failures | ✅ | Secrets removed from config, HTTPS enforced via HSTS |
| A03 - Injection (XSS) | ✅ | CSP headers + Jekyll pinned to 4.3.4+ |
| A04 - Insecure Design | ⚠️ | Ongoing — no user input accepted (static site) |
| A05 - Security Misconfiguration | ✅ | Security headers added, help_tips disabled in prod |
| A06 - Vulnerable Components | ✅ | Gem versions pinned, bundler-audit in CI |
| A07 - Auth Failures | ✅ | No auth implemented; gitalk credentials removed |
| A08 - Software Integrity | ✅ | Gemfile.lock committed, TruffleHog secrets scan in CI |
| A09 - Logging Failures | ✅ | GitHub Actions security scanning with audit log |
| A10 - SSRF | N/A | Static site — no server-side requests |

---

## Compliance Framework Mapping

### PCI-DSS v4.0
| Requirement | Control | Implementation |
|-------------|---------|----------------|
| 6.3.2 | Inventory of bespoke software | GitHub dependency graph + Dependabot |
| 6.3.3 | Security patches applied | Pinned gems + bundler-audit CI |
| 6.4.1 | Security headers | `_headers` file with CSP, HSTS, X-Frame-Options |
| 6.4.2 | Code review | PR review required before merge to main |
| 8.6.1 | No hardcoded credentials | Secrets removed; GitHub Secrets used |

### SOC 2 Type II
| Trust Service Criteria | Control | Implementation |
|------------------------|---------|----------------|
| CC6.1 | Logical access controls | GitHub branch protection + secret management |
| CC6.6 | Security headers prevent unauthorized access | CSP, X-Frame-Options, HSTS |
| CC7.1 | Vulnerability detection | bundler-audit + Semgrep + Dependabot in CI |
| CC8.1 | Change management | Security CI validates every PR/push |

---

## Security Scanning Schedule

| Scan Type | Tool | Frequency | Owner |
|-----------|------|-----------|-------|
| SCA (Gems) | bundler-audit | Every push + weekly | CI/CD |
| SCA (JS) | retire.js | Every push + weekly | CI/CD |
| SAST | Semgrep | Every push + weekly | CI/CD |
| Secrets | TruffleHog | Every push | CI/CD |
| Dependency Updates | Dependabot | Weekly | Automated PRs |
| Manual Penetration Test | Manual | Annually | Security Team |

---

## References

- [OWASP Top 10 2021](https://owasp.org/Top10/)
- [OWASP Secure Coding Practices](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/)
- [NIST Secure Software Development Framework (SSDF)](https://csrc.nist.gov/Projects/ssdf)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [Jekyll Security Policy](https://github.com/jekyll/jekyll/security/policy)
- [CWE Top 25 Most Dangerous Weaknesses](https://cwe.mitre.org/top25/)

# BIGPEDAL - AI-Powered E-Government Platform

> Next-generation digital government services for Bulgarian citizens, powered by AI and built with modern web technologies.

[![Next.js](https://img.shields.io/badge/Next.js-14-black?logo=next.js)](https://nextjs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.9-blue?logo=typescript)](https://www.typescriptlang.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-3.4-38B2AC?logo=tailwind-css)](https://tailwindcss.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 🌟 Overview

BIGPEDAL is a comprehensive e-government platform that streamlines access to 117 Bulgarian government services through an intuitive, AI-powered interface. Built with Next.js 14 and TypeScript, it provides citizens with step-by-step guidance, intelligent document processing, and qualified electronic signatures.

**📚 [Full Documentation](https://docs.bigpedal.net)** | **🚀 [Live Demo](https://bigpedal.net)** | **💬 [Community](https://github.com/RoleplayBG/urban-winner/discussions)**

## ✨ Key Features

### 🤖 CivicAI Assistant
- **Natural language understanding** in Bulgarian and English
- **RAG-powered policy search** through government documentation
- **Document analysis** with OCR and intelligent extraction
- **Service recommendations** based on user needs
- Powered by **Google Gemini** (gemini-1.5-flash)

### 🔐 Secure Authentication
- **NextAuth.js** with credentials provider
- **EGN validation** (Bulgarian national ID)
- **Optional email OTP** for enhanced security
- **Rate limiting** (IP + EGN based)
- **Role-based access control** (USER, ADMIN)

### 📋 Service Navigator
- **117 government services** across 14 categories
- **Step-by-step guides** with document checklists
- **Real-time application tracking**
- **Official portal integration**
- **Mobile-responsive** design

### ✍️ Qualified Electronic Signature (QES)
- **Evrotrust integration** for legally binding signatures
- **Async signing workflow** with status tracking
- **Secure document storage** via Vercel Blob
- **Demo provider** for development/testing

### 📱 Progressive Web App
- **Offline support** with service worker
- **Installable** on desktop and mobile
- **Push notifications** for application updates
- **App shortcuts** for quick access

## 🛠️ Tech Stack

| Category | Technologies |
|----------|-------------|
| **Framework** | Next.js 14 (App Router), React 18, TypeScript 5.9 |
| **Styling** | Tailwind CSS 3.4, Radix UI, Lucide Icons |
| **Authentication** | NextAuth.js 4.24, bcrypt |
| **Database** | Prisma 5.19, PostgreSQL |
| **AI/ML** | Google Gemini, Vercel AI SDK, Fuse.js |
| **Storage** | Vercel Blob |
| **Email** | Nodemailer |
| **Testing** | Vitest, Playwright |
| **Deployment** | Vercel, Docker |

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- PostgreSQL database
- Google Gemini API key (optional, for AI features)

### Installation

```bash
# Clone the repository
git clone https://github.com/RoleplayBG/urban-winner.git
cd urban-winner/web

# Install dependencies
npm install

# Set up environment variables
cp .env.example .env.local
# Edit .env.local with your configuration

# Run database migrations
npx prisma migrate dev

# Start development server
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

### Essential Environment Variables

```env
# Database
DATABASE_URL=postgresql://user:pass@host:5432/bigpedal

# Authentication
NEXTAUTH_SECRET=your-secret-here  # Generate: openssl rand -base64 32
NEXTAUTH_URL=http://localhost:3000

# AI (Optional)
GOOGLE_AI_API_KEY=your-gemini-api-key

# Email (Optional, for OTP)
SMTP_HOST=smtp.example.com
SMTP_PORT=587
SMTP_USER=your-email@example.com
SMTP_PASS=your-password
SMTP_FROM=noreply@example.com

# QES (Optional)
QES_PROVIDER=demo  # or 'evrotrust' for production
VERCEL_BLOB_READ_WRITE_TOKEN=vercel_blob_...

# Cron Jobs
CRON_SECRET=your-cron-secret
```

See [full environment configuration](https://docs.bigpedal.net/deployment#environment-variables) in the documentation.

## 📁 Project Structure

```
web/
├── app/                    # Next.js App Router
│   ├── (auth)/            # Authentication routes
│   ├── api/               # API routes
│   ├── dashboard/         # User dashboard
│   ├── navigator/         # Service navigator
│   └── qes/               # QES interface
├── components/            # React components
│   ├── ui/               # Reusable UI components
│   ├── dashboard/        # Dashboard widgets
│   └── services/         # Service components
├── lib/                  # Utility libraries
│   ├── auth/             # Auth utilities
│   ├── ai/               # AI integration
│   ├── prisma/           # Database client
│   └── qes/              # QES providers
├── prisma/               # Database schema
│   ├── schema.prisma     # Prisma schema
│   └── migrations/       # Database migrations
├── data/                 # Static data
│   └── egov/             # E-gov service definitions
└── tests/                # Test suites
    ├── unit/             # Vitest unit tests
    └── e2e/              # Playwright E2E tests
```

## 🧪 Testing

```bash
# Unit tests (Vitest)
npm run test
npm run test:watch
npm run test:coverage

# E2E tests (Playwright)
npm run test:e2e
npx playwright test --ui

# Type checking
npm run typecheck

# Linting
npm run lint
```

**Test Coverage:**
- ✅ 74 passing unit tests across 13 test files
- ✅ E2E tests for critical user flows
- ✅ Authentication, AI, QES, and service workflows

## 🚀 Deployment

### Vercel (Recommended)

1. **Connect your repository** to Vercel
2. **Configure environment variables** in project settings
3. **Deploy** - automatic on push to main

```bash
# Or deploy manually
npm run build
vercel --prod
```

### Docker

```bash
# Build image
docker build -t bigpedal .

# Run container
docker run -p 3000:3000 --env-file .env bigpedal
```

See [deployment guide](https://docs.bigpedal.net/deployment) for detailed instructions.

## 📖 Documentation

Comprehensive documentation is available at **[docs.bigpedal.net](https://docs.bigpedal.net)**:

- **[Architecture](https://docs.bigpedal.net/architecture)** - System design and tech stack
- **[Authentication](https://docs.bigpedal.net/authentication)** - Auth setup and security
- **[API Routes](https://docs.bigpedal.net/api-routes)** - Complete API reference
- **[Database](https://docs.bigpedal.net/database)** - Prisma schema and migrations
- **[CivicAI](https://docs.bigpedal.net/civic-ai)** - AI assistant integration
- **[QES](https://docs.bigpedal.net/qes)** - Electronic signature setup
- **[Service Navigator](https://docs.bigpedal.net/service-navigator)** - Service catalog
- **[Deployment](https://docs.bigpedal.net/deployment)** - Production deployment
- **[Testing](https://docs.bigpedal.net/testing)** - Testing strategy

## 🎯 Available Scripts

| Command | Description |
|---------|-------------|
| `npm run dev` | Start development server |
| `npm run build` | Build for production |
| `npm run start` | Start production server |
| `npm run test` | Run unit tests |
| `npm run test:e2e` | Run E2E tests |
| `npm run typecheck` | Type checking |
| `npm run lint` | Lint code |
| `npx prisma studio` | Open database GUI |
| `npx prisma migrate dev` | Run migrations |

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## 📊 Performance

- **Lighthouse Score**: 95+ (Performance, Accessibility, Best Practices, SEO)
- **Core Web Vitals**: All metrics in "Good" range
- **Bundle Size**: Optimized with code splitting and lazy loading
- **PWA**: Offline support with service worker caching

## 🔒 Security

- **Authentication**: Secure password hashing with bcrypt
- **Rate Limiting**: IP and EGN-based protection
- **CSRF Protection**: Built-in NextAuth CSRF tokens
- **SQL Injection**: Prevented via Prisma ORM
- **XSS Protection**: React's built-in escaping
- **HTTPS**: Enforced in production

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Next.js](https://nextjs.org/) - The React framework
- [Tailwind CSS](https://tailwindcss.com/) - Utility-first CSS
- [Radix UI](https://www.radix-ui.com/) - Accessible components
- [Prisma](https://www.prisma.io/) - Next-generation ORM
- [Google Gemini](https://ai.google.dev/) - AI capabilities
- [Vercel](https://vercel.com/) - Deployment platform

## 📞 Support

- **Documentation**: [docs.bigpedal.net](https://docs.bigpedal.net)
- **Issues**: [GitHub Issues](https://github.com/RoleplayBG/urban-winner/issues)
- **Discussions**: [GitHub Discussions](https://github.com/RoleplayBG/urban-winner/discussions)
- **Email**: support@bigpedal.net

---

**Made with ❤️ for Bulgarian citizens** | [Website](https://bigpedal.net) | [Documentation](https://docs.bigpedal.net) | [GitHub](https://github.com/RoleplayBG/urban-winner)

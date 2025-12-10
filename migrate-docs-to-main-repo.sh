#!/bin/bash

# Migration script to transfer documentation to urban-winner main repository
# This script will create a PR-ready branch with all documentation files

set -e  # Exit on error

echo "🚀 BIGPEDAL Documentation Migration Script"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/RoleplayBG/urban-winner.git"
BRANCH_NAME="docs/add-comprehensive-documentation"
DOCS_REPO_PATH="$(pwd)"

echo -e "${BLUE}📋 Configuration:${NC}"
echo "  Repository: $REPO_URL"
echo "  Branch: $BRANCH_NAME"
echo "  Current docs path: $DOCS_REPO_PATH"
echo ""

# Ask for confirmation
read -p "Do you want to proceed? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Migration cancelled."
    exit 1
fi

# Create temporary directory
TEMP_DIR=$(mktemp -d)
echo -e "${BLUE}📁 Creating temporary directory: $TEMP_DIR${NC}"

# Clone the repository
echo -e "${BLUE}📥 Cloning urban-winner repository...${NC}"
git clone "$REPO_URL" "$TEMP_DIR/urban-winner"
cd "$TEMP_DIR/urban-winner"

# Create new branch
echo -e "${BLUE}🌿 Creating new branch: $BRANCH_NAME${NC}"
git checkout -b "$BRANCH_NAME"

# Create docs directory
echo -e "${BLUE}📂 Creating docs directory...${NC}"
mkdir -p docs

# Copy documentation files
echo -e "${BLUE}📄 Copying documentation files...${NC}"

# List of files to copy
declare -a DOC_FILES=(
    "index.mdx"
    "architecture.mdx"
    "authentication.mdx"
    "api-routes.mdx"
    "database.mdx"
    "civic-ai.mdx"
    "qes.mdx"
    "deployment.mdx"
    "testing.mdx"
    "service-navigator.mdx"
    "docs.json"
    "quickstart.mdx"
    "development.mdx"
)

# Copy each file
for file in "${DOC_FILES[@]}"; do
    if [ -f "$DOCS_REPO_PATH/$file" ]; then
        echo "  ✓ Copying $file"
        cp "$DOCS_REPO_PATH/$file" "docs/$file"
    else
        echo "  ⚠ Warning: $file not found, skipping..."
    fi
done

# Copy logo and favicon if they exist
if [ -d "$DOCS_REPO_PATH/logo" ]; then
    echo "  ✓ Copying logo directory"
    cp -r "$DOCS_REPO_PATH/logo" "docs/"
fi

if [ -f "$DOCS_REPO_PATH/favicon.svg" ]; then
    echo "  ✓ Copying favicon"
    cp "$DOCS_REPO_PATH/favicon.svg" "docs/"
fi

# Replace README.md
echo -e "${BLUE}📝 Replacing README.md...${NC}"
if [ -f "$DOCS_REPO_PATH/NEW_README.md" ]; then
    cp "$DOCS_REPO_PATH/NEW_README.md" "README.md"
    echo "  ✓ README.md replaced"
else
    echo "  ⚠ Warning: NEW_README.md not found, skipping..."
fi

# Create .mintlify.json if it doesn't exist
echo -e "${BLUE}⚙️  Creating Mintlify configuration...${NC}"
cat > docs/.mintlify.json << 'EOF'
{
  "name": "BIGPEDAL Documentation",
  "logo": {
    "light": "/logo/light.svg",
    "dark": "/logo/dark.svg"
  }
}
EOF
echo "  ✓ .mintlify.json created"

# Create docs README
echo -e "${BLUE}📖 Creating docs/README.md...${NC}"
cat > docs/README.md << 'EOF'
# BIGPEDAL Documentation

This directory contains the comprehensive documentation for the BIGPEDAL platform.

## 📚 Documentation Structure

- `index.mdx` - Overview and introduction
- `architecture.mdx` - System architecture and tech stack
- `authentication.mdx` - Authentication and security
- `api-routes.mdx` - API endpoints reference
- `database.mdx` - Database schema and Prisma
- `civic-ai.mdx` - AI assistant features
- `qes.mdx` - Qualified Electronic Signature
- `deployment.mdx` - Deployment guide
- `testing.mdx` - Testing strategy
- `service-navigator.mdx` - Service catalog

## 🚀 Viewing Documentation

### Local Development

```bash
# Install Mintlify CLI
npm install -g mintlify

# Start documentation server
cd docs
mintlify dev
```

Open [http://localhost:3000](http://localhost:3000) to view the documentation.

### Production

Documentation is automatically deployed to [docs.bigpedal.net](https://docs.bigpedal.net) when changes are merged to main.

## 📝 Contributing to Documentation

1. Edit the relevant `.mdx` file
2. Test locally with `mintlify dev`
3. Commit and push changes
4. Documentation will auto-deploy

## 🔗 Links

- **Live Documentation**: https://docs.bigpedal.net
- **Main Repository**: https://github.com/RoleplayBG/urban-winner
- **Mintlify Docs**: https://mintlify.com/docs
EOF
echo "  ✓ docs/README.md created"

# Add all changes
echo -e "${BLUE}➕ Staging all changes...${NC}"
git add .

# Check if there are changes to commit
if git diff --staged --quiet; then
    echo -e "${YELLOW}⚠️  No changes to commit. Documentation might already be up to date.${NC}"
    cd "$DOCS_REPO_PATH"
    rm -rf "$TEMP_DIR"
    exit 0
fi

# Show what will be committed
echo -e "${BLUE}📊 Changes to be committed:${NC}"
git status --short

# Commit changes
echo -e "${BLUE}💾 Creating commit...${NC}"
git commit -m "docs: Add comprehensive documentation and update README

- Add complete documentation for BIGPEDAL platform
- Include architecture, authentication, API, database guides
- Add CivicAI, QES, and service navigator documentation
- Include deployment and testing guides
- Replace README.md with comprehensive version
- Set up Mintlify documentation structure

Documentation includes:
- System architecture and tech stack
- Authentication with NextAuth.js and OTP
- Complete API reference for all endpoints
- Database schema with Prisma
- AI assistant (CivicAI) integration
- Qualified Electronic Signature (QES)
- Service Navigator for 117 e-services
- Deployment guide for Vercel and Docker
- Testing strategy with Vitest and Playwright"

echo ""
echo -e "${GREEN}✅ Migration completed successfully!${NC}"
echo ""
echo -e "${BLUE}📍 Next steps:${NC}"
echo "  1. Review the changes:"
echo "     cd $TEMP_DIR/urban-winner"
echo "     git log -1 --stat"
echo ""
echo "  2. Push the branch to GitHub:"
echo "     cd $TEMP_DIR/urban-winner"
echo "     git push origin $BRANCH_NAME"
echo ""
echo "  3. Create a Pull Request on GitHub:"
echo "     https://github.com/RoleplayBG/urban-winner/compare/$BRANCH_NAME"
echo ""
echo -e "${YELLOW}📂 Repository location: $TEMP_DIR/urban-winner${NC}"
echo ""
echo "Would you like to push the branch now? (y/n)"
read -p "> " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}🚀 Pushing to GitHub...${NC}"
    git push origin "$BRANCH_NAME"
    echo ""
    echo -e "${GREEN}✅ Branch pushed successfully!${NC}"
    echo ""
    echo -e "${BLUE}🔗 Create your PR here:${NC}"
    echo "   https://github.com/RoleplayBG/urban-winner/compare/$BRANCH_NAME"
    echo ""
else
    echo ""
    echo -e "${YELLOW}⏸️  Branch not pushed. You can push it manually later:${NC}"
    echo "   cd $TEMP_DIR/urban-winner"
    echo "   git push origin $BRANCH_NAME"
    echo ""
fi

echo -e "${GREEN}🎉 All done! Happy reviewing!${NC}"
echo ""
echo "Note: The repository is in: $TEMP_DIR/urban-winner"
echo "You can delete it after the PR is merged with: rm -rf $TEMP_DIR"

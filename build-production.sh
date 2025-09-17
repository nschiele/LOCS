#!/bin/bash

# Production Build Script for LOCS Hugo Site
# This script mimics what the GitHub Actions workflow does

set -e  # Exit on any error

echo "🔧 Building LOCS Hugo site in production mode..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if Hugo is installed
if ! command -v hugo &> /dev/null; then
    echo -e "${RED}❌ Hugo is not installed. Please install Hugo first.${NC}"
    echo "Visit: https://gohugo.io/installation/"
    exit 1
fi

# Check Hugo version
echo -e "${BLUE}📋 Hugo version:${NC}"
hugo version

# Clean previous build
echo -e "${YELLOW}🧹 Cleaning previous build...${NC}"
rm -rf public/
rm -f config.prod.toml

# Create production config
echo -e "${YELLOW}⚙️  Creating production configuration...${NC}"
cp config.toml config.prod.toml

# Use relative baseURL for maximum portability across different domains/subpaths
sed -i 's|baseURL = "http://localhost:1313/"|baseURL = "/"|' config.prod.toml

# Enable relative URLs for better portability
echo 'relativeURLs = true' >> config.prod.toml
echo 'canonifyURLs = false' >> config.prod.toml

# Build the site
echo -e "${YELLOW}🏗️  Building Hugo site...${NC}"
HUGO_ENV=production hugo --config config.prod.toml --minify --gc

# Show build statistics
echo -e "${GREEN}✅ Build completed successfully!${NC}"
echo -e "${BLUE}📊 Build statistics:${NC}"
echo "   - Total files: $(find public -type f | wc -l)"
echo "   - Total size: $(du -sh public | cut -f1)"
echo "   - HTML files: $(find public -name "*.html" | wc -l)"
echo "   - CSS files: $(find public -name "*.css" | wc -l)"
echo "   - JS files: $(find public -name "*.js" | wc -l)"
echo "   - Images: $(find public -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.gif" -o -name "*.svg" | wc -l)"

echo -e "${GREEN}🚀 Production build ready in './public/' directory${NC}"
echo -e "${BLUE}💡 To test locally, run:${NC} python3 -m http.server 8080 --directory public"

# Clean up
echo -e "${YELLOW}🧹 Cleaning up temporary files...${NC}"
rm -f config.prod.toml

echo -e "${GREEN}🎉 All done!${NC}"

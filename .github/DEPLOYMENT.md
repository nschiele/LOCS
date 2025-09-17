# Automated Hugo Site Deployment

This repository is configured with automated deployment using GitHub Actions.

## How It Works

1. **Trigger**: The deployment workflow runs automatically whenever you push commits to the `main` (or `master`) branch.

2. **Build Process**:
   - Checks out the repository with full history
   - Sets up Hugo (latest extended version)
   - Installs Node.js dependencies if needed
   - Creates a production configuration
   - Builds the site with `HUGO_ENV=production`
   - Minifies and optimizes the output

3. **Deployment**: The built site is automatically deployed to the `compiled` branch.

## Branches

- **`main`/`master`**: Source code and content
- **`compiled`**: Auto-generated production build (do not edit manually)

## Configuration

### Production URL Configuration
The workflow automatically configures the site for production builds using relative URLs:
- `baseURL = "/"` - Uses relative base URL for maximum portability
- `relativeURLs = true` - Enables relative URL generation
- `canonifyURLs = false` - Prevents absolute URL canonicalization

This configuration allows the site to work on any domain or subdirectory without modification, including:
- GitHub Pages: `https://username.github.io/repository/`
- Custom domains: `https://yourdomain.com/`
- Subdirectories: `https://example.com/subpath/`

### Manual Deployment
You can trigger a deployment manually by:
1. Going to the "Actions" tab in your GitHub repository
2. Selecting the "Build and Deploy Hugo Site" workflow
3. Clicking "Run workflow"

## Monitoring Deployments

- Check the "Actions" tab to see deployment status
- Each deployment shows build logs and statistics
- Failed deployments will show error details

## Local Development

For local development, continue using:
```bash
hugo server --disableFastRender --noHTTPCache --watch --port 1313
```

## Serving the Compiled Site

The `compiled` branch contains static files that can be served by any web server. You can:

1. **Use GitHub Pages**: Enable GitHub Pages to serve from the `compiled` branch
2. **Local testing**: Clone the `compiled` branch and serve with any static server:
   ```bash
   git clone -b compiled https://github.com/nschiele/LOCS.git locs-compiled
   cd locs-compiled
   python3 -m http.server 8080
   ```

## Troubleshooting

### Common Issues

1. **Build fails**: Check the Actions logs for Hugo build errors
2. **Missing dependencies**: Ensure all Hugo themes and Node.js dependencies are properly configured
3. **Deployment fails**: Verify repository permissions and branch protection rules

### Debug Information

Each deployment includes:
- Hugo version used
- Build statistics
- File listing of generated content
- Commit information and timestamps

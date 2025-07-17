##### GitHub Pages Deployment
https://roadmap.sh/projects/github-actions-deployment-workflow

# GitHub Deployment Workflow
This project demonstrates a basic GitHub Actions workflow for continuous integration and deployment. It deploys `index.html` to GitHub Pages whenever it is updated in the `main` branch.

##### Solution
Step 1: Create the Repository
Step 2: Add Files
      1. index.html
      2. README.md
      3. .github/workflows/deploy.yml
Step 3: Push Everything to GitHub
Step 4: Enable GitHub Pages

##### Result
Now when you change index.html and push to main, your GitHub Actions workflow will:
Run automatically.
Deploy the updated file to GitHub Pages.

You can view it at:
📎 https://<your-username>.github.io/gh-deployment-workflow/

##### NOTE:
My workwas not working i have checked everything like:
1. Is the workflow file in the correct location?
     .github/workflows/deploy.yml
2. Does your workflow file listen only to index.html changes?
         on:
      push:
        branches:
          - main
        paths:
          - 'index.html'
       # This will only trigger when index.html is changed on the main branch.

3. Are your commits actually modifying index.html?
4. Is Actions enabled in the repo?
    Go to GitHub repo → Settings → Actions → General, and make sure Actions are enabled for the repository.

5. Check the Actions tab
    Click the "Actions" tab in your GitHub repo:
    See if any workflows are running.
    See if there are any errors.
    If nothing is showing up, the workflow is not being triggered.

6. Has GitHub Pages been configured correctly?
    Go to your repo on GitHub.
    Click Settings → Pages (in the sidebar) → Under Build and Deployment, choose: → Source: GitHub Actions → Save it.

In my case:
gh-deployment-workflow/
├── README3.md
├── index.html
└── .github/
    └── workflows/
        └── deploy.yml
This means:
    My index.html is not at the root of the repository.
    It is actually inside a subdirectory: gh-deployment-workflow/index.html.
    
# Solution:
  Option 1: Move Files to Repo Root (Recommended)
      Move index.html and README3.md to the root of the repo, alongside .github.
      your-repo/
          ├── .github/
          │   └── workflows/
          │       └── deploy.yml
          ├── index.html
          └── README.md

  Option 2: Update Workflow to Match File Location
     If you want to keep the current structure, update the paths: section like this:
        on:
        push:
          branches:
            - main
          paths:
            - 'gh-deployment-workflow/index.html'
      But GitHub Pages will deploy the root folder by default — so you'd also need to change this:
        In pages artifects job:
        with:
          path: 'gh-deployment-workflow'

Error: Ensure GITHUB_TOKEN has permission "id-token: write".

I was encountering this error because the actions/deploy-pages@v4 action requires OpenID Connect (OIDC) and the GITHUB_TOKEN must have id-token: write permission — which is not enabled by default in some cases.

Solution: Explicitly Set Permissions in Workflow
You need to update your deploy.yml and add the correct permissions block at the top level of the **jobs: section**
    permissions:  # ✅ This is required
      contents: read
      pages: write
      id-token: write  # ✅ Required for OIDC to work

Now my workflow file was all set and successfully worked.

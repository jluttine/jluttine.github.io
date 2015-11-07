<!-- 
.. title: Blog with Jupyter (IPython) Notebook and Nikola
.. slug: blog-with-jupyter-ipython-notebook-and-nikola
.. date: 2015-11-04 19:05:01 UTC+02:00
.. tags: 
.. category: 
.. link: 
.. description: 
.. type: text
-->


http://www.damian.oquanta.info/posts/blogging-with-nikola-and-ipython.html

http://sampathweb.com/posts/blogging-made-easy.html


# Set up the environment

I recommend you use Virtualenv and Virtualenvwrapper for setting up the
environment.  After installing both, run the following command and put it to
your shell startup file:

    source virtualenvwrapper.sh

Then crea

    mkdir -p /path/to/blog
    mkvirtualenv --system-site-packages -a /path/to/blog blog
    
Install NumPy, SciPy, Matplotlib and Pandoc using the package manager of your
system. Install Nikola to your virtual environment with some useful extra
packages:

    pip install nikola[extras]


# Create the site

Assuming you are in the directory of your blog, initialize Nikola there:

    nikola init .

Edit conf.py and modify `POSTS` and `PAGES` as follows:

    POSTS = (
        ("posts/*.ipynb", "posts", "post.tmpl"),
        ("posts/*.md", "posts", "post.tmpl"),
        ("posts/*.rst", "posts", "post.tmpl"),
        ("posts/*.txt", "posts", "post.tmpl"),
    )
    PAGES = (
        ("pages/*.md", "pages", "story.tmpl"),
        ("pages/*.ipynb", "pages", "story.tmpl"),
        ("pages/*.rst", "stories", "story.tmpl"),
        ("pages/*.txt", "stories", "story.tmpl"),
    )

The first entries are used as defaults. With these settings, blog posts would be
Jupyter Notebooks and pages would be Markdown files by default if no format is
specified explicitly.


# Initialize git

Initializing git for the blog requires a few extra steps if we want to deploy
the site to GitHub user/organization pages. First, initialize the repository:

    git init
    git add *
    git commit -am "Initial commit"
    
Push your code to a GitHub repository:

    git remote add origin https://github.com/jluttine/jaakkoluttinen.fi.git
    git push origin -u


# Create content

Create your first blog post and answer a few questions:

    nikola new_post -f ipynb

Create your first page and answer a few questions:

    nikola new_page -f markdown
    
It isn't necessary to specify `-f format` if you want to use the default
format. In order to edit the blog post, launch Jupyter Notebook:

    jupyter notebook posts

In order to see your site, use Nikola to automatically refresh your site at
http://127.0.0.1:8000/:

    nikola auto

Both of these processes will block your terminal until you stop them. Thus, I
recommend opening separate dedicated terminals for the processes so they can run
without blocking your working terminal.


# Deploy to GitHub pages

Because the compiled website is static, there are lots of options where to serve
your website. GitHub is a convenient place to deploy, so here are basic
instructions for that. But you could use any other location and define your own
`DEPLOY_COMMANDS` in `conf.py` to be used when running `nikola deploy`. For
GitHub pages, you can use `nikola github_deploy`.

Define the settings for the GitHub pages:

    GITHUB_SOURCE_BRANCH = 'master'
    GITHUB_DEPLOY_BRANCH = 'gh-pages'
    GITHUB_REMOTE_NAME = 'origin'

If you are using a custom domain name, add `CNAME` to `files` directory:

    echo www.jaakkoluttinen.fi > files/CNAME

Deploy the static site to GitHub:

    nikola github_deploy

Now your blog should be running, go and check out.

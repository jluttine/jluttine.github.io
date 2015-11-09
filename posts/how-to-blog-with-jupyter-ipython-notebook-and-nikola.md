<!-- 
.. title: How to blog with Jupyter (IPython) Notebook and Nikola
.. slug: how-to-blog-with-jupyter-ipython-notebook-and-nikola
.. date: 2015-11-04 19:05:01 UTC+02:00
.. tags: jupyter,ipython,notebook,nikola,conf.py
.. category: 
.. link: 
.. description: 
.. type: text
-->

I have thought about starting a blog for a few years now and when I recently
found some amazing tools which can be used in a data science blog I got so
excited that I just needed to finally start my blog.  I have used Python with
the NumPy/SciPy stack

I got my inspiration mainly from [Damian Avila's
blog](http://www.damian.oquanta.info/).

[a](http://www.damian.oquanta.info/posts/blogging-with-nikola-and-ipython.html).
[b](http://sampathweb.com/posts/blogging-made-easy.html)

Although setting things up for the blog wasn't that difficult, there were some steps that neede....
So, this first blog post will give you instructions on how to create a blog.


# Set up the environment

I recommend you use Virtualenv and Virtualenvwrapper for setting up the
environment.  After installing both, run the following command and put it to
your shell startup file:

    source virtualenvwrapper.sh

Create (and activate) a virtual environment:

    mkdir -p /path/to/blog
    mkvirtualenv --system-site-packages -a /path/to/blog blog
    
Install NumPy, SciPy, Matplotlib and Pandoc using the package manager of your
system (or use, for instance, Anaconda). Install Nikola to your virtual
environment with some useful extra packages:

    pip install nikola[extras]


# Create the site

Assuming that you are in the directory of your blog project, initialize Nikola:

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

I recommend you use git and GitHub because it makes publishing and sharing your
blog posts and notebooks easy.  The repository can be initialized as:

    git init
    git add *
    git commit -am "Initial commit"
    
Push your code to a GitHub repository:

    git remote add origin https://github.com/USERNAME/PROJECTNAME.git
    git push origin -u


# Create content

Create your first blog post:

    nikola new_post -f ipynb

Create your first page:

    nikola new_page -f markdown
    
It isn't necessary to specify `-f format` if you want to use the default
format. In order to edit the blog post, launch Jupyter Notebook:

    jupyter notebook posts

Note that you may need to use `ipython` instead of `jupyter` if you have an old
version installed.  In order to see your site, use Nikola to automatically
refresh your site at http://127.0.0.1:8000/:

    nikola auto

Both of these processes will block your terminal until you stop them. Thus, I
recommend opening separate dedicated terminals for the processes so they can run
without blocking your working terminal.


# Deploy to GitHub pages

Because the compiled website is static, there are lots of options where to serve
your website. GitHub is a convenient place to deploy, so here are basic
instructions for that. But you could use any other location and define your own
`DEPLOY_COMMANDS` in `conf.py` to be used when running `nikola deploy`. For
GitHub pages, you can use `nikola github_deploy` and define a few parameters:

    GITHUB_SOURCE_BRANCH = 'master'
    GITHUB_DEPLOY_BRANCH = 'gh-pages'
    GITHUB_REMOTE_NAME = 'origin'

If you are using a custom domain name, add `CNAME` to `files` directory:

    echo mycustomdomain.com > files/CNAME

Deploy the static site to GitHub:

    nikola github_deploy

Now your blog should be up and running.


# Customize the site

## Choose a theme

You can easily customize the look of your blog by creating a new theme.
[Bootswatch](https://bootswatch.com/) offers free themes which can be easily
used in your Nikola project.  After choosing the Bootswatch theme, create your
custom theme:

    nikola bootswatch_theme -n YOUR_THEME_NAME -s BOOTSWATCH_THEME_NAME -p ipython

I recommend using IPython theme as the parent theme but you can choose any other
[Nikola theme](https://themes.getnikola.com/). Now modify your `conf.py` to use
the new custom theme:

    THEME = "YOUR_THEME_NAME"

## Add social media links

If you want to use social media icons from [Font
Awesome](https://fortawesome.github.io/Font-Awesome/), add the following
definition to `conf.py`:

```
EXTRA_HEAD_DATA = '<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">'
```

Then you can add some social media icons and links, for instance, to the footer
by adding the following lines to `conf.py`:

```
CONTENT_FOOTER = '''
<div class="text-center">
<p>
<span class="fa-stack fa-2x">
  <a href="https://twitter.com/jluttine">
    <i class="fa fa-circle fa-stack-2x"></i>
    <i class="fa fa-twitter fa-inverse fa-stack-1x"></i>
  </a>
</span>

<span class="fa-stack fa-2x">
  <a href="https://github.com/jluttine">
    <i class="fa fa-circle fa-stack-2x"></i>
    <i class="fa fa-github fa-inverse fa-stack-1x"></i>
  </a>
</span>

<span class="fa-stack fa-2x">
  <a href="https://www.linkedin.com/in/jluttine">
    <i class="fa fa-circle fa-stack-2x"></i>
    <i class="fa fa-linkedin fa-inverse fa-stack-1x"></i>
  </a>
</span>

<span class="fa-stack fa-2x">
  <a href="mailto:{email}">
    <i class="fa fa-circle fa-stack-2x"></i>
    <i class="fa fa-envelope fa-inverse fa-stack-1x"></i>
  </a>
</span>

<span class="fa-stack fa-2x">
  <a href="/rss.xml">
    <i class="fa fa-circle fa-stack-2x"></i>
    <i class="fa fa-rss fa-inverse fa-stack-1x"></i>
  </a>
</span>
</p>
<p>
  Contents &copy; {date}  <a href="mailto:{email}">{author}</a>
  &mdash;
  {license}
  &mdash;
  Powered by <a href="https://getnikola.com" rel="nofollow">Nikola</a>
</p>
</div>
'''
```

Just remember to change the usernames in each of the social media links.


## Miscellaneous settings

You can also add a license for your content:

```
LICENSE = """
<a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/">
  <img alt="Creative Commons License BY-SA"
       style="border-width:0; margin-bottom:12px;"
       src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png">
</a>
"""
```

And some other configuration suggestions for you to consider:

```
CREATE_SINGLE_ARCHIVE = True
INDEX_TEASERS = True
```

That's it, I hope this was useful.  If you have ideas how to improve setting up
the blog, please comment below.
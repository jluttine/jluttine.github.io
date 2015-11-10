<!-- 
.. title: How to blog with Jupyter (IPython) Notebook and Nikola
.. slug: how-to-blog-with-jupyter-ipython-notebook-and-nikola
.. date: 2015-11-10 22:05:01 UTC+02:00
.. tags: jupyter,ipython,notebook,nikola,conf.py
.. category: 
.. link: 
.. description: 
.. type: text
-->

I have thought about starting a blog for a few years now and when I recently
found some amazing tools which can be used in a data science blog I got so
excited that I finally had to start my blog.  I have used Python and the
[NumPy](http://www.numpy.org/)/[SciPy](http://scipy.org/) stack to analyze and
model data for a few years now.  I'm also passionate about open data and open
science, so I've been excited about how [Jupyter Notebooks](http://jupyter.org/)
(a.k.a. [IPython Notebooks](http://ipython.org/)) can be used to share a mixture
of reproducible code and commentation.  And with Nikola, it is possible to set
up a whole blogging system based on posts written as Notebooks making it
possible for anyone to easily try the analysis shown in the post.

I got some inspiration from [Damian Avila's
blog](http://www.damian.oquanta.info/).  He has written [instructions on
blogging with Nikola and
IPython](http://www.damian.oquanta.info/posts/blogging-with-nikola-and-ipython.html).
However, the instructions are outdated so I thought I'd start my blog by giving
my own tips on setting up Nikola with Jupyter.

<!-- TEASER_END -->

# Set up the environment

First, install NumPy, SciPy, [Matplotlib](http://matplotlib.org/), IPython and
Jupyter (if available) by using the package manager of your system (or use, for
instance, [Anaconda](https://www.continuum.io/downloads)).  I recommend you use
[Virtualenv](https://virtualenv.readthedocs.org/en/latest/) and
[Virtualenvwrapper](https://virtualenvwrapper.readthedocs.org/en/latest/) for
setting up a virtual environment for the blog.  After installing the packages,
run the following command and put it to your shell startup file:

    source virtualenvwrapper.sh

Create (and activate) a virtual environment:

    mkdir -p /path/to/blog
    mkvirtualenv --system-site-packages -a /path/to/blog blog
    
Install Nikola to your virtual environment with some useful extra packages:

    pip install nikola[extras]

You can leave the virtual environment with `deactivate` and activate it with
`workon blog`.


# Create the site

Assuming that you are in the directory of your blog project, initialize Nikola:

    nikola init .

Edit conf.py and modify `POSTS` and `PAGES` as follows:

    POSTS = (
        ("posts/*.ipynb", "blog", "post.tmpl"),
        ("posts/*.md", "blog", "post.tmpl"),
        ("posts/*.rst", "blog", "post.tmpl"),
        ("posts/*.txt", "blog", "post.tmpl"),
    )
    PAGES = (
        ("pages/*.md", "", "story.tmpl"),
        ("pages/*.ipynb", "", "story.tmpl"),
        ("pages/*.rst", "", "story.tmpl"),
        ("pages/*.txt", "", "story.tmpl"),
    )

The first format entries are used as defaults, so with these settings blog posts
would be Jupyter Notebooks and pages would be Markdown files by default if no
format is specified explicitly.  Also, the blog posts would be located in
`/blog/` and pages (e.g., `/about/`) in the root.


# Initialize git

I recommend you use git and [GitHub](https://github.com/) because it makes
publishing and sharing your blog posts and notebooks easy.  The repository can
be initialized as:

    git init
    git add *
    git commit -am "Initial commit"
    
Push your code to a GitHub repository:

    git remote add origin https://github.com/USERNAME/PROJECTNAME.git
    git push origin -u


# Create content

Create your first blog post:

    nikola new_post -f ipynb

Create your first page (for instance, "About"):

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

Because the compiled website is static, there are lots of options where you can
serve your website. GitHub is a convenient place to deploy, so here are basic
instructions for that, but you could use any other location and define your own
`DEPLOY_COMMANDS` (in `conf.py`) to be used when running `nikola deploy`. For
GitHub pages, you can use `nikola github_deploy` after defining a few
parameters:

    GITHUB_SOURCE_BRANCH = 'master'
    GITHUB_DEPLOY_BRANCH = 'gh-pages'
    GITHUB_REMOTE_NAME = 'origin'

If you are using a custom domain name, add `CNAME` to `files` directory:

    echo mycustomdomain.com > files/CNAME

Deploy the static site to GitHub:

    nikola github_deploy

Now your blog should be up and running.


# Fine-tune the settings

You can already start blogging.  The rest of this post will just provide some
ideas on how to improve the settings.

## Choose a theme

You can easily customize the look of your blog by creating a new theme.
[Bootswatch](https://bootswatch.com/) offers free themes which can be easily
used in your Nikola project.  After choosing the Bootswatch theme, create your
custom theme:

```
nikola install_theme ipython
nikola bootswatch_theme -n YOUR_THEME_NAME -s BOOTSWATCH_THEME_NAME -p ipython
```

I recommend using IPython theme as the parent theme but you can choose any other
[Nikola theme](https://themes.getnikola.com/). Now modify your `conf.py` to use
the new custom theme:

    THEME = "YOUR_THEME_NAME"

## Add social media links

If you want to use social media icons from [Font
Awesome](https://fortawesome.github.io/Font-Awesome/), add the following
definition to `conf.py`:

```
EXTRA_HEAD_DATA = '<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">'
```

Then you can add some social media icons and links, for instance, to the footer
by adding the following lines to `conf.py`:

```
CONTENT_FOOTER = '''
<div class="text-center">
<p>
<span class="fa-stack fa-2x">
  <a href="/rss.xml">
    <i class="fa fa-circle fa-stack-2x"></i>
    <i class="fa fa-rss fa-inverse fa-stack-1x"></i>
  </a>
</span>
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


## Write math

You can write math in your blog either inline as `\\( X \sim \mathcal{N}(0,1)
\\)` which looks like \\( X \sim \mathcal{N}(0,1) \\) or in display mode as

```
$$
\mathcal{N}(x|\mu, \sigma) = \frac{1}{\sigma\sqrt{2\pi}} e^{-\frac{(x-\mu)^2}{2\sigma^2}}
$$
```

which looks like

$$
\mathcal{N}(x|\mu, \sigma) = \frac{1}{\sigma\sqrt{2\pi}} e^{-\frac{(x-\mu)^2}{2\sigma^2}}
$$

By default, [MathJax](https://www.mathjax.org/) is used but there is also
support for a very promising fast math renderer called
[KaTeX](http://khan.github.io/KaTeX/).  However, I wasn't able to enable KaTeX.


## Add a license

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


## Remove .html suffix from archive.html

This is just a small annoyance, but by default, the archive is located in
`/archive.html`.  If you want it to be in `/archive/`, add the following lines
to your `conf.py`:

```
ARCHIVE_PATH = "archive"
ARCHIVE_FILENAME = "index.html"
```

Remember to also fix the navigation links:

```
NAVIGATION_LINKS = {
    DEFAULT_LANG: (
        ("/archive/", "Archive"),
        ("/categories/", "Tags"),
        ("/rss.xml", "RSS feed"),
        ("/about/", "About"),
    ),
}
```

## Miscellaneous settings

Here are some other configuration suggestions for you to consider.  If you want
the archive to show all your blog posts as a single list instead of a year and
month based hierarchy, use the following setting:

```
CREATE_SINGLE_ARCHIVE = True
```

To show only short teasers instead of full posts on index pages:

```
INDEX_TEASERS = True
```

Remember to mark the teasers in your blog posts with `<!-- TEASER_END -->` in
Markdown.


# Conclusion

That's it, I hope this was useful.  Of course, there are lots of configuration
options to modify your site, so I recommend you read the brief [Nikola
handbook](https://getnikola.com/handbook.html) to get an overview.  Also, if you
have ideas on how to improve the setting up of a blog, please comment below.

And yes, I know, this blog post isn't a notebook.  But the next one will be and
in that post I'll share one amazing tool that I just discovered a few days ago
related to notebook blogging.

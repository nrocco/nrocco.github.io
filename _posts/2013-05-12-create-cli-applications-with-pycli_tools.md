---
layout: post
title: Create cli applications with pycli_tools
---

> A python module to help create predictable command line tools

`pycli_tools` is a python module that wraps the `ArgumentParser` class from the
build-in `argparse` module. If you use it in your command line scripts you will
get some defaults options added to your application such as `--verbose` and
`--quiet` to control the verbosity of your application (using the python logging
module). Also there is the `--config` option that gives you the ability to read
command line arguments from a configuration file to save users of your
application a lot of typing.

<!-- more -->

You can install `pycli_tools` using pip. Vist the pypi page [here][pypi_page].

    $ pip install pycli_tools

Or you can clone the latest 'bleeding edge' version directly from github
[here][github_page].

    $ git clone https://github.com/nrocco/pycli-tools.git
    $ cd pycli-tools
    $ python setup.py install


The best way to illustrate its usefulness is by example.
For an example on how to use the pycli_tools python module head over to its
github page and [read the README.md][github_page] file overthere.


[github_page]: https://github.com/nrocco/pycli-tools
[pypi_page]: https://pypi.python.org/pypi/pycli_tools

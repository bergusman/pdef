# encoding: utf-8
from distutils.core import setup

setup(
    name='pdef',
    version='1.0-alpha7',
    url='http://github.com/ivan-korobkov/pdef',
    author='Ivan Korobkov',
    author_email='ivan.korobkov@gmail.com',
    description='Pdef interface language',
    license='Apache License 2.0',
    package_dir={'': 'src'},
    packages=['pdef', 'pdef.java'],
    package_data={'pdef': ['java/*.template']},
    scripts=['scripts/pdefc'],
    requires=['argparse', 'jinja2', 'ply']
)

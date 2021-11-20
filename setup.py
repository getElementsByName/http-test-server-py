## setup.py
from glob import glob
from os.path import basename, splitext
from setuptools import find_packages, setup


def parse_requirements(filename):
    """ load requirements from a pip requirements file """
    lineiter = (line.strip() for line in open(filename))
    return [line for line in lineiter if line and not line.startswith("#")]

install_reqs = parse_requirements('requirements.txt')
setup(
    name='http_test_server_py',
    version='0.1',
    packages=find_packages(where='http_test_server_py'),
    package_dir={'': 'src'},
    py_modules=[splitext(basename(path))[0] for path in glob('src/*.py')],
    install_requires=install_reqs
)
Install numpy matplotlib pandas jupyter
=====
* Install
```sh
apt install clang python python-dev fftw libzmq-dev freetype-dev libpng-dev libcrypt-dev pkg-config -y
pip install pip==9.0.3 # https://github.com/pypa/pip/issues/5171
# For pip >= 10, Use pip install --no-build-isolation
LDFLAGS=" -lm -lcompiler_rt" pip install -vvv --upgrade --force-reinstall --no-cache-dir cython numpy matplotlib pandas bokeh jupyter
# pip install scipy will not work because termux doesn' hava a fortran compiler, so don't do it
```
* Test
```python
# pip install -U nose2
import nose, numpy, scipy
numpy.test('full')
scipy.test('full')
```

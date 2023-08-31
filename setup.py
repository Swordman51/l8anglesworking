from setuptools import setup
from setuptools.extension import Extension
import numpy
from Cython.Build import cythonize
import os

NAME = "l8angles"
DESC = "Polymer atmospheric correction algorithm (http://dx.doi.org/10.1364/OE.19.009783)"
SRC_DIR = 'l8angles'
DEBUG=False
ANNOTATE=True


if DEBUG:
    compiler_directives = {
            'profile': True,
            'embedsignature': True,
            }
else:
    compiler_directives = {
            'boundscheck': False,
            'initializedcheck': False,
            'cdivision': True,
            'embedsignature': True,
            }

includes = ["ias_lib/ias_angle_gen_write_image.o", "l8_angles.o", "ias_lib/ias_misc_write_envi_header.o", "ias_lib/ias_misc_create_output_image_trim_lut.o", "ias_lib/ias_math_find_line_segment_intersection.o", "ias_lib/ias_geo_convert_dms2deg.o"]
newargs = []
for t in includes:
  newargs.append(os.getcwd()+ "/src/" + t)


extensions = [
    Extension("l8angles", ["l8angles.pyx"],
              include_dirs = ["src/", "src/ias_lib/", numpy.get_include()],
              libraries=["l8ang"],
              library_dirs=[ os.getcwd() + "/src/ias_lib", os.getcwd() + "/src"],
              extra_compile_args = newargs,
              extra_link_args=newargs)
]

EXTENSIONS = cythonize(
		       extensions,
		       #['l8angles.pyx'],
                       build_dir='build',
                       compiler_directives=compiler_directives,
                       annotate=ANNOTATE,
                         
                       )

setup(
    name = NAME,
    description = DESC,
    ext_modules = EXTENSIONS,
    #include_dirs = ["src", "src/ias_lib", "c_build", "build" ,numpy.get_include()],
    #package_dir={'c_build': './c_build'},
    #package_data={'c_build': ['*.so']},
    )


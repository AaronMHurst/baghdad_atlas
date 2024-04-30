# The Baghdad Atlas

This project is based on the original (*n,n'*&gamma;) measurements carried out
by A.M. Demidov *et al.* [[1]](#1).  The resulting datasets are compiled into a
set of CSV-style files and Python scripts are provided to build a corresponding
SQLite relational database.  This project is described in detail in the
reference article *The Baghdad Atlas: A relational database of inelastic
neutron-scattering (n,n'&gamma;) data* by A.M. Hurst *et al.*[[2]](#2).

The complete software package includes the following:

(i) Scripts to compile the data into a SQLite database for both Python 2 and 
Python 3.  The Makefile will determine the appropriate version.

(ii) A C-code to produce the extension-functions library allowing for 
mathematical functions (e.g., square root) to be invoked that are not standard 
methods with the SQLite3 engine.  The Makefile will establish the OS kernel 
name and compile the library accordingly.

(iii) The complete set of CSV data files compiled for nuclei within the 
range Z=3-92; a total of 105 data sets comprising 76 natural-sample and 29 
isotopically-enriched measurements.

(iv) A Jupyter Notebook illustrating methods for interacting with and 
visualizing the data.

(v) Several SQL scripts providing database-interaction examples.  The 
OS-dependent library providing enhanced functionality with SQLite3 methods will 
be defined automatically during installation.

(vi) A PDF of the original ATLAS [1978De41] and the corresponding NIMA
reference article [2021Hu05] is also provided.

(vii) An HTML manual describing the software installation procedure and 
data-access methods.  An overview of the ATLAS data is also provided in the
documentation.

For further information regarding this ATLAS, including detailed installation
and utilization, please refer to document/index.html.

# Building and installation

This project should be built after cloning the repository at the terminal
command line of the `src` directory:

```Bash
$ git clone https://github.com/AaronMHurst/baghdad_atlas.git
$ cd baghdad_atlas/src
$ make && make run && make install
```

For clean-up operations type:

```Bash
$ make help
```

## References:

<a id="1">[1]</a>
A.M. Demidov, I. Govor, Yu. K. Cherepantsev, M.R. Ahmed, S. Al-Najjar,
M.A. Al-Amili, N. Al-Assafi, N. Rammo, *"Atlas of Gamma-Ray Spectra from the 
Inelastic Scattering of Reactor Fast Neutrons"*, Nuclear Research Institute,
Baghdad, Iraq (Moscow, Atomizdat 1978).

<a id="2">[2]</a>
A.M. Hurst, L.A. Bernstein, T. Kawano, A.M. Lewis, K. Song, 
*"The Baghdad Atlas: A relational database of inelastic neutron-scattering 
(n,n'&gamma;) data"*, Nucl. Instrum. Methods Phys. Sect. A **995**, 165095
(2021).

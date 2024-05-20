# The Baghdad Atlas

This project is based on the original (*n,n'*&gamma;) measurements carried out
by A.M. Demidov *et al.* [[1]](#1).  The resulting datasets are compiled into a
set of CSV-style files and `Python` scripts are provided to build a
corresponding `SQLite` relational database.  A data-retrieval example for the
Fe data is shown in comparison to the measured Fe spectrum in the figure below.

Measured Fe spectrum | Database-retrieved Fe data
:-------------------:|:--------------------:
![Measured](Fe_spectrum.png?raw=true "Fe spectrum measured at the Baghdad Research Reactor.") | ![Queried](Fe_cs_query.png?raw=true "Fe data retrieved using a SQL database query.")

This project is described in detail in the reference article *The Baghdad Atlas:
A relational database of inelastic neutron-scattering (n,n'&gamma;) data* by
A.M. Hurst *et al.* [[2]](#2).  Absolute cross sections for all transitions in
the *Baghdad Atlas* can be derived relative to the flux-weighted cross section
deduced for the 2<sup>+</sup> $\rightarrow$ 0<sub>gs</sub><sup>+</sup>
transition in <sup>56</sup>Fe [[2]](#2); the normalization transition of the
Atlas.  The characterized flux used in this determination is shown in comparison
to the measured flux at the IRT-M Baghdad Research Reactor in the figure below.

![Flux](opt_and_para_fit.png?raw=true "Measured, parametrized, and optimized flux at the baghdad Research Reactor.")

The complete software package includes the following:

(i) Scripts to compile the data into a `SQLite` database for both `Python2` and 
`Python3`.  The `Makefile` provided will determine the appropriate version.

(ii) A `C` program to produce the extension-functions library allowing for 
mathematical functions (e.g., square root, trigonometry, logarithm) to be
invoked that are not standard methods with the `SQLite3` engine.  The `Makefile'
will establish the OS kernel name and compile the library accordingly.

(iii) The complete set of CSV-style data files compiled for nuclei within the 
range Z=3-92; a total of 105 data sets comprising 76 natural-sample and 29 
isotopically-enriched measurements.

(iv) A `Jupyter Notebook` illustrating methods for interacting with and 
visualizing the data.

(v) A suite of `SQL` scripts is also provided to illustraste
database-interaction methods using the `SQLite` interpreter.  The 
OS-dependent library providing enhanced functionality with `SQLite3` methods
will be defined automatically during installation.

(vi) A `PDF` of the original Atlas [1978De41] and the corresponding NIMA
reference article [2021Hu05] is also provided.

(vii) An `HTML` manual describing the software installation procedure and 
data-access methods.  An overview of the Atlas data is also provided in the
documentation.

For further information regarding this Atlas, including detailed installation
and utilization, please refer to `document/index.html`.

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

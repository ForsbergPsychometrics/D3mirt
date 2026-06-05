# D3mirt 2.0.5
- Rgl widget opens in R console as defualt
- Changed scale argument to default TRUE for scaling vector length with MDISC.
- Orthogonal model now reoprts DISC instead of MDISC
- D and C removed from table when reporting direction cosines


# D3mirt 2.0.4
- New workflow integration which only requires the user to state what model identification items should be used by D3mirt() (no external model syntax required).
- A new optional model, referred to as the orthogonal model, is included in D3mirt() which allows investigating a three-dimensional scale under the assumption that no within-multidimensionality exists.
- Respondent trait scores are included in the exported S3 object from D3mirt(), which allows for easy plotting of respondents using plot().
- Constructs can be created using subsets of items or spherical coordinates, which allows for adding constructs anywhere in the latent space.
- Test units have been developed to cover all functions in the package. Slimmed versions of the test units, for basic functionality, are included in the CRAN version of the package while the full version of the test units are available for download at the dedicated Github page (https://github.com/ForsbergPyschometrics/D3mirt).
- Vignette is now a static PDF file to save space and installation time. The previous interactive HTML document was error prone and slow to load because of its large size. 
- Contact information regarding questions, code contribution, and reporting bugs has been included in the package vignette.
- Minor revisions of documentation, code, and description file.

# D3mirt 1.1.0
- Examples in README extended
- Revisions of documentation

# D3mirt 1.0.5
- Print method added to the modid() and D3mirt() functions
- Summary method added to the modid() function
- Plot function changed to use generic plot() method
- mirt::mirt() function integrated into modid() and D3mirt()
- Minor revisions of documentation

# D3mirt 1.0.4
- Minor fix regarding error message in plot function
- Minor documentation revisions

# D3mirt 1.0.3
- Minor documentation revisions

# D3mirt 1.0.2
- Change of D parameter to MDIFF
- Minor documentation revisions

# D3mirt 1.0.1
 -First release

# D3mirt 1.0.0

# D3mirt 0.0.0.9000

* Added a NEWS.md file to track changes to the package.

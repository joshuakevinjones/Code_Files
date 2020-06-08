# checks to see whether packages are already installed, and, if not, installs them

# Install required R libraries, if they are not already installed.
if (!('ggmap' %in% rownames(installed.packages()))){install.packages('ggmap')}
if (!('mapproj' %in% rownames(installed.packages()))){install.packages('mapproj')}
if (!('ROCR' %in% rownames(installed.packages()))){install.packages('ROCR')}
if (!('RODBC' %in% rownames(installed.packages()))){install.packages('RODBC')}
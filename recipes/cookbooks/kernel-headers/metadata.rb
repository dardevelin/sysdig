name              "kernel-headers"
maintainer        "nobody"
description       "Installs kernel headers"
version           "0.0.1"
recipe            "kernel-headers", "Installs packages required for compiling C kernel things"

%w{ ubuntu debian }.each do |os|
  supports os
end

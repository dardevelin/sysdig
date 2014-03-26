name              "gdb"
maintainer        "nobody"
description       "Installs gdb"
version           "0.0.1"
recipe            "gdb", "Installs gdb"

%w{ ubuntu debian }.each do |os|
  supports os
end

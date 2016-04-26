name             'tc-webrio'
maintainer       'Thomas Cook'
maintainer_email 'infrastructure.team@thomascookonline.com'
license          'All rights reserved'
description      'Installs WebRIO'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'
depends          'tc-java'
depends          'locale', '~> 1.0.2'
# TODO remove version pin on tar when we migrate to chefspec 4.1+
depends          'tar', '= 0.5.0'
depends          'tc-base', '>= 0.6.0'
depends          'ark', '~> 0.9.0'
depends	         'swap_tuning', '~> 0.2.0'

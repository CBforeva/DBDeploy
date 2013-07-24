DBDeploy
========

Database deployment puppet scripts, in order to unify test environments
for the CustomSamplers extension for JMeter.

Supporting the installation and configuration of the following databases:
SQL:
----
 + Oracle 11g XE - You need to download the appropriate Oracle 11g XE RPM into modules/oracle/files/

NoSQL:
------
 + CouchDB

Dependencies
------------
Puppet modules:
 + puppetlabs/create_resources
 + puppetlabs/stdlib

Credits
-------
 + The base of the  Oracle module is from Codescape (https://github.com/codescape/vagrant-oracle-xe).
   I just modified it to work on RedHat based systems, and added the support of swap file mounting.

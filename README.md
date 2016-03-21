DBDeploy
========
This project is a collection of puppet manifests and scripts to deploy databases on CERN OpenStack instances, in order to create unified test environments for the CustomSamplers extension of JMeter.

The list of supported databases are:
NoSQL:
------
 + Cassandra
 + CouchDB
 + HBase
 + Hypertable
 + MongoDB
 + RIAK

Relational:
----
 + Oracle 11g XE - You need to download the appropriate Oracle 11g XE RPM into modules/oracle/files/
 + Oracle 11g SE
 + MySQL
 + PostgreSQL

Dependencies:
-------------
Most of these manifests have puppet module dependencies that are marked in the first few lines of the manifest files. Some of the manifests have an install.sh script that are automatically installs these dependencies and calls a puppet apply with the manifest.
Some modules may have patches or additional config files that are located under the modules directory.


CC7 - CondDB-Mon:
-----------------
This directory contains the manifest files to restore the CondDB Monitoring site.


Credits:
--------
 + The base of the  Oracle module is from Codescape (https://github.com/codescape/vagrant-oracle-xe).
   I just modified it to work on RedHat based systems, and added the support of swap file mounting.


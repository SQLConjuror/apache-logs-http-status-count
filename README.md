# apache-logs-http-status-count
Counts the number of HTTP 4xx and 5xx response statuses in the apache log file. If the cumulative number of errors exceeds 100, this script will send email alert reporting on the high number of error responses and relevant information.

## Usage

You need to supply the apache log filename as a parameter to the script.

```bash
./responsestatscount.sh <apachelogfile>
```
## Crontab
Make the shell script run every hour by using the crontab utility. 

```bash
##################################################################################################
# Cronbtab
##################################################################################################
#
# * * * * * command to be executed
# | | | | +----- day of week (0 - 6) (Sunday=0)
# | | | +------- month (1 - 12)
# | | +--------- day of month (1 - 31)
# | +----------- hour (0 - 23)
# +------------- min (0 - 59)
#
0 * * * * /scripts/responsestatscount.sh apache.log
```
## Author

* **Jose Enrique Valencia** - *Initial work* - [PurpleBooth](https://github.com/SQLConjuror)

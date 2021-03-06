# the aide class manages some the configuration of aide
class aide (
  $package         = $aide::params::package,
  $version         = $aide::params::version,
  $conf_path       = $aide::params::conf_path,
  $db_path         = $aide::params::db_path,
  $db_temp_path    = $aide::params::db_temp_path,
  $hour            = $aide::params::hour,
  $minute          = $aide::params::minute,
  $gzip_dbout      = $aide::params::gzip_dbout,
  $aide_path       = $aide::params::aide_path,
  $mailto          = $aide::params::mailto,
  $aide_log        = $aide::params::aide_log,
  $syslogout       = $aide::params::syslogout,
  $config_template = $aide::params::config_template,
  $cron_template   = $aide::params::cron_template,
  $nocheck         = $aide::params::nocheck,
) inherits aide::params {

  anchor { 'aide::begin': }

  -> class  { '::aide::install':
      version => $version,
      package => $package,
    }

  -> class  { '::aide::cron':
      aide_path     => $aide_path,
      db_path       => $db_path,
      minute        => $minute,
      hour          => $hour,
      mailto        => $mailto,
      cron_template => $cron_template,
      nocheck       => $nocheck,
    }

  -> class  { '::aide::config':
      conf_path       => $conf_path,
      db_path         => $db_path,
      db_temp_path    => $db_temp_path,
      gzip_dbout      => $gzip_dbout,
      aide_log        => $aide_log,
      syslogout       => $syslogout,
      config_template => $config_template,
    }

  ~> class  { '::aide::firstrun':
      aide_path    => $aide_path,
      conf_path    => $conf_path,
      db_temp_path => $db_temp_path,
      db_path      => $db_path,
    }

  -> anchor { 'aide::end': }

}

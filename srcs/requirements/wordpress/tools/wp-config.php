<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'MYSQL_DB_NAME' );

/** Database username */
define( 'DB_USER', 'MYSQL_USER' );

/** Database password */
define( 'DB_PASSWORD', 'MYSQL_PW' );

/** Database hostname */
define( 'DB_HOST', 'MARIADB_HOST' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'uFfCV?E%,_y:wOZ;gsFhV51O9Zwh#!6Z[.:?e==yAew>0M ,s>%!GLL+ri1{3RA?');
define('SECURE_AUTH_KEY',  'jK&@:N|f{&J,,z)+Z9X`2S8&6.,//!u7oKm/-rE[+D5A4Hq0X-X]0h+{@8y6QO,{');
define('LOGGED_IN_KEY',    'xX&(fI#8X,*n_nxD4|-35^+x|;< Ac> VOkWNW{+Ek|}M=&IF `Jcqlth{p-Px~]');
define('NONCE_KEY',        '?%++*#-L`0t?:kbh7cps.3>jTlO?jote+w(C!}y+8 Kfb*G|NWB-Md:H-UwkAHr+');
define('AUTH_SALT',        'aZNS+!`>M-lFjy7eL5NRjwUie`T!R/-.CTG{4+r*:~$+er|ceP!S) Zy^]#}o>(-');
define('SECURE_AUTH_SALT', 'sm 4HqrD||a68g!A<X$|$XTq<YG=s0$xn/h)`6YRI@ D3CDIclyYcmR#FUrTRic-');
define('LOGGED_IN_SALT',   '&Z]kXQ41/rSq1|I z/PJalX}*F$t>{h9qv.lMr%LK|MXM/w{CbNr,kbR]JjntR%#');
define('NONCE_SALT',       '8zbNR_dJ| S*Ag?#`3^3k{O)n t@Q:!QfkHZW*F?H8]kxjL^]Ht)Y|.-y.ae!yyr');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';

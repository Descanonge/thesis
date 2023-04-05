
$success_cmd = 'src/parse_log.sh build/%R.log';
$failure_cmd = 'src/parse_log.sh build/%R.log';

add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
    my ($base_name, $path) = fileparse( $_[0] ); #handle -outdir param by splitting path and file, ...
    pushd $path; # ... cd-ing into folder first, then running makeglossaries ...

    if ( $silent ) {
        system "makeglossaries -q '$base_name'"; #unix
    }
    else {
        system "makeglossaries '$base_name'"; #unix
    };

    popd; # ... and cd-ing back again
}
push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
$clean_ext .= ' %R.ist %R.xdy';

$silence_logfile_warnings = 0;
$analyze_input_log_always = 0;

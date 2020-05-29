test: clean
	tests/start_end_no_error_ut.sh
	tests/start_end_error_ut.sh
	tests/log_messages_ut.sh
	tests/set_var_ut.sh
	tests/run_ut.sh
#	./compare_folder.sh tests tests

clean:
	rm -rf tests/*.log output

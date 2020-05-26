test: clean
	tests/start_end_no_error_ut.sh
	tests/start_end_error_ut.sh
	./compare_folder.sh tests tests

clean:
	rm -rf tests/*.log output

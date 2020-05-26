test: clean
	tests/start_end_no_error_ut.sh
	tests/start_end_error_ut.sh

clean:
	rm -f tests/*.log

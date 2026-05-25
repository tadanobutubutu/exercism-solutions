proc custom_error_message {message} {
    return -code error -errorcode CUSTOM $message
}

proc handle_error {script} {
    if {[catch {uplevel 1 $script} result]} {
        if {[string match "*divide by zero*" $result]} {
            return "division by zero"
        }
        if {[string match "*no such file or directory*" $result]} {
            return "file does not exist"
        }
        if {[string match "*invalid command name*" $result]} {
            return "proc does not exist"
        }
        return $result
    }
    return "success"
}

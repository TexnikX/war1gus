if(LHASA_INCLUDE_DIR AND LHASA_LIBRARIES)
	set(LHASA_FOUND true)
else()
	find_path(LHASA_INCLUDE_DIR NAMES liblhasa-1.0/lhasa.h)
	find_library(LHASA_LIBRARIES NAMES liblhasa lhasa)

	if(LHASA_LIBRARIES AND LHASA_INCLUDE_DIR)
		set(LHASA_FOUND true)
		message(STATUS "Found lhasa: ${LHASA}:${LHASA_INCLUDE_DIR}")
	else()
		set(LHASA_FOUND false)
		message(WARNING "Could not find lhasa")
	endif()

	mark_as_advanced(LHASA_LIBRARIES LHASA_INCLUDE_DIR)
endif()

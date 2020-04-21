if(NOT TARGET ofxCurl)
  # Define ${ofxCurl_PROJECT_ROOT}. ${CMAKE_CURRENT_LIST_DIR} is just the current directory.
  get_filename_component(ofxCurl_PROJECT_ROOT "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)

  # Define ${CINDER_PATH} as usual.
  get_filename_component(CINDER_PATH "${ofxCurl_PROJECT_ROOT}/../.." ABSOLUTE)

  # Make a list of source files and define that to be ${SOURCE_LIST}.
  file(GLOB SOURCE_LIST CONFIGURE_DEPENDS
      "${ofxCurl_PROJECT_ROOT}/src/rph/NotificationManager.cpp"
      "${ofxCurl_PROJECT_ROOT}/src/rph/Notification.cpp"
      )

  # Create the library!
  add_library(ofxCurl ${SOURCE_LIST})

  # Add include directories.
  # Notice that `cinderblock.xml` has `<includePath>src</includePath>`.
  # So you need to set `../../src/` to include.
  target_include_directories(ofxCurl PUBLIC "${ofxCurl_PROJECT_ROOT}/src" )
  target_include_directories(ofxCurl SYSTEM BEFORE PUBLIC "${CINDER_PATH}/include" )


  # If your Cinder block has no source code but instead pre-build libraries,
  # you can specify all of them here (uncomment the below line and adjust to your needs).
  # Make sure to use the libraries for the right platform.
  # # target_link_libraries(ofxCurl "${Cinder-OpenCV_PROJECT_ROOT}/lib/libopencv_core.a")

  if(NOT TARGET cinder)
    include("${CINDER_PATH}/proj/cmake/configure.cmake")
    find_package(cinder REQUIRED PATHS
        "${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
        "$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}")
  endif()
  target_link_libraries(ofxCurl PRIVATE cinder)

endif()

file(GLOB SOURCE_LIST CONFIGURE_DEPENDS
    "${ofxCurl_PROJECT_ROOT}/src/**/*.h"
    "${ofxCurl_PROJECT_ROOT}/src/**/*.hpp"
    "${ofxCurl_PROJECT_ROOT}/src/**/*.cc"
    "${ofxCurl_PROJECT_ROOT}/src/**/*.cpp"
    "${ofxCurl_PROJECT_ROOT}/src/**/*.c"
    "${ofxCurl_PROJECT_ROOT}/src/*.h"
    "${ofxCurl_PROJECT_ROOT}/src/*.hpp"
    "${ofxCurl_PROJECT_ROOT}/src/*.cc"
    "${ofxCurl_PROJECT_ROOT}/src/*.cpp"
    "${ofxCurl_PROJECT_ROOT}/src/*.c")
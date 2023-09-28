cmake_minimum_required(VERSION 3.16)

project(CarDashboard VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 REQUIRED COMPONENTS Core Quick Mqtt)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Quick Mqtt)

qt_add_executable(appCarDashboard
    main.cpp
)

qt_add_qml_module(appCarDashboard
    URI CarDashboard
    VERSION 1.0
    QML_FILES main.qml
    QML_FILES FuelGauge.qml Rpmometar.qml Turn.qml
    RESOURCES icons/absoff.png icons/abson.png icons/batteryoff.png icons/batteryon.png icons/blinkeroff.png icons/blinkeron.png icons/engineoff.png icons/engineon.png icons/fueloff.png icons/fuelon.png icons/pojasoff.png icons/pojason.png icons/rucnaoff.png icons/rucnaon.png images/gearbox_visual_1.png images/gearbox_visual_2.png images/gearbox_visual_3.png images/gearbox_visual_4.png images/gearbox_visual_5.png
    QML_FILES PraviSpeed.qml
    SOURCES qmlclient.h qmlclient.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appCarDashboard PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appCarDashboard
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appCarDashboard
    PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Mqtt)

include(GNUInstallDirs)
install(TARGETS appCarDashboard
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

import windy/common

export common

when defined(windows):
  import windy/platforms/win32/platform
elif defined(linux):
  import windy/platforms/x11/platform

type
  Window* = ref object
    platform: PlatformWindow

proc init*() {.raises: [WindyError]} =
  platformInit()

proc newWindow*(
  title: string,
  w: int,
  h: int,
  vsync = true,
  openglMajorVersion = 4,
  openglMinorVersion = 1,
  msaa = msaa8x,
  depthBits = 0,
  stencilBits = 0
): Window {.raises: [WindyError]} =
  # resizeable, fullscreen, transparent, decorated, floating
  result = Window()
  result.platform = newPlatformWindow(
    title,
    w,
    h,
    vsync,
    openglMajorVersion,
    openglMinorVersion,
    msaa,
    depthBits,
    stencilBits
  )

proc makeContextCurrent*(window: Window) {.raises: [WindyError]} =
  window.platform.makeContextCurrent()

proc swapBuffers*(window: Window) {.raises: [WindyError]} =
  window.platform.swapBuffers()

proc pollEvents*() =
  platformPollEvents()

proc `visible`*(window: Window): bool =
  discard

proc `visible=`*(window: Window, visible: bool) =
  if visible:
    window.platform.show()
  else:
    window.platform.hide()

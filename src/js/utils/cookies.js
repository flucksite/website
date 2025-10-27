export function setCookie(name, value, expires) {
  if (expires) {
    const now = new Date()
    now.setTime(now.getTime() + expires * 24 * 60 * 60 * 1000)
    writeCookie(name, value, now.toUTCString())
  } else {
    writeCookie(name, value)
  }
}

export function getCookie(name) {
  const cookies = decodeURIComponent(document.cookie).split(';')
  name += '='

  for (let i = 0, cookie; i < cookies.length; i++) {
    cookie = cookies[i]
    while (cookie.charAt(0) === ' ') cookie = cookie.substring(1)
    if (cookie.indexOf(name) === 0)
      return cookie.substring(name.length, cookie.length)
  }
}

export function eraseCookie(name) {
  writeCookie(name, '', new Date(1970).toUTCString())
}

function writeCookie(name, value, expires) {
  if (expires) expires = `expires=${expires};`
  document.cookie = `${name}=${value};${expires}path=/;SameSite=Lax`
}

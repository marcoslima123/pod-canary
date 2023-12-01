// pages/_app.tsx
import { useEffect } from 'react';
import Cookies from 'js-cookie';
import type { AppProps } from 'next/app';

function MyApp({ Component, pageProps }: AppProps) {
  useEffect(() => {
    if (!Cookies.get('userSessionId')) {
      const sessionId = generateUniqueSessionId();
      Cookies.set('userSessionId', sessionId, { expires: 1 });
    }
  }, []);

  return <Component {...pageProps} />;
}

function generateUniqueSessionId() {
  return 'sess-' + Math.random().toString(36).substr(2, 9);
}

export default MyApp;
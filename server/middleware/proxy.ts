import { defineEventHandler, proxyRequest } from 'h3';

export default defineEventHandler(async (event) => {
  // Only handle /api routes
  if (!event.path.startsWith('/fetch')) {
    return;
  }

  const config = useRuntimeConfig();

  console.log('Proxy Middleware Called:', {
    path: event.path,
    method: event.method,
  });

  // Remove /fetch prefix and construct target URL properly
  const targetPath = event.path.replace(/^\/fetch/, ``);
  const targetUrl = `${config.public.apiBase}${targetPath}`;

  console.log('Proxying to:', targetUrl);

  try {
    // Add custom headers
    const headers = {
      ...Object.fromEntries(event.headers.entries()),
      'X-API-Key': config.public.apiKey,
      'x-proxy-timestamp': new Date().toISOString(),
      'x-request-id': crypto.randomUUID(),
      'User-Agent': 'trackinvest/1.0',
      Accept: 'application/json',
    };

    // Remove problematic headers
    delete headers.host;
    delete headers.connection;
    delete headers['content-length'];

    return await proxyRequest(event, targetUrl, {
      headers,
      fetchOptions: {
        timeout: 5000,
      },
    });
  } catch (error) {
    console.error('Proxy Error:', error);
    return {
      error: true,
      message: 'Failed to fetch data from backend',
      details: error.message,
    };
  }
});

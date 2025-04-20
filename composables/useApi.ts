export function useApi() {
  const getData = async (
    p_api: string,
    p_method: string,
    p_body: any,
    p_headers: any
  ) => {
    try {
      const { data, status } = await useFetch(p_api, {
        method: p_method,
        body: p_body,
        headers: p_headers,
      });

      return data;
    } catch (error) {
      console.error('error:', error);
      return error;
    }
  };

  return {
    getData,
  };
}

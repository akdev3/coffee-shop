import axios from 'axios';

const routePrefix = 'api/v1/'
axios.interceptors.request.use(
  (config) => {
    config.headers['accept'] = 'application/json';
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

export const get = async (url, params = {}) => {
  try {
    const response = await axios.get(`${routePrefix}${url}`, { params });
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
};

export const post = async (url, data = {}) => {
  try {
    const response = await axios.post(`${routePrefix}${url}`, data);
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
};

export const put = async (url, data = {}) => {
  try {
    const response = await axios.put(`${routePrefix}${url}`, data);
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
};

export const del = async (url) => {
  try {
    const response = await axios.delete(`${routePrefix}${url}`);
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
};

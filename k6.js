import http from 'k6/http';
import { check, sleep, fail } from 'k6';

export const options = {
  stages: [
    { duration: '30s', target: 1000 },
    // { duration: '30s', target: 50 },
    // { duration: '30s', target: 50 },
    // { duration: '10s', target: 0 },
  ],
  thresholds: {
    http_req_duration: ['p(95)<800'],
    http_req_failed: ['rate<0.01'],
  },
};

const BASE_URL = __ENV.BASE_URL || 'http://127.0.0.1:8080';
const KEY_PREFIX = __ENV.KEY_PREFIX || 'load_key';
const WRITE_RATIO = Number(__ENV.WRITE_RATIO || 0.1);

export default function () {
  const id = Math.floor(Math.random() * 1000000);
  const key = `${KEY_PREFIX}_${id}`;

  const doWrite = Math.random() < WRITE_RATIO;

  if (doWrite) {
    const value = `value_${id}`;
    const res = http.get(
      `${BASE_URL}/set?key=${key}&value=${value}`,
      { tags: { type: 'write' } },
    );

    check(res, {
      'write status is 200': (r) => r.status === 200,
    });
  } else {
    const res = http.get(
      `${BASE_URL}/get?key=${key}`,
      { tags: { type: 'read' } },
    );

    check(res, {
      'read status is 200': (r) => r.status === 200,
    });
  }

  sleep(0.1);
}
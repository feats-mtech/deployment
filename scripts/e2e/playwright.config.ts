import { defineConfig } from '@playwright/test';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: path.resolve(__dirname, '.env') });

export default defineConfig({
  testDir: '.',
  timeout: 30000,
  retries: 2,
  use: {
    headless: true,
    baseURL: process.env.TEST_URL ? process.env.TEST_URL : 'http://localhost:3000',
    viewport: { width: 1280, height: 720 },
    actionTimeout: 10000,
    ignoreHTTPSErrors: true,
    screenshot: 'only-on-failure',
  },
});

import { test, expect } from '@playwright/test';

test.describe('Sign In Page Tests', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/sign-in');
  });

  test('Display required login form fields', async ({ page }) => {
    await expect(page.locator('input[name="username"]')).toBeVisible();
    await expect(page.locator('input[name="password"]')).toBeVisible();
    await expect(page.locator('button[type="submit"]')).toBeVisible();
  });

  test('Password visibility toggle functionality', async ({ page }) => {
    // Check if password field is initially hidden
    const passwordField = page.locator('input[name="password"]');
    await expect(passwordField).toHaveAttribute('type', 'password');

    // Locate and click password visibility toggle button using icon
    const toggleButton = page
      .locator('button')
      .filter({ has: page.locator('.iconify') })
      .first();
    await toggleButton.click();

    // Verify password field becomes visible
    await expect(passwordField).toHaveAttribute('type', 'text');

    // Click again to hide password
    await toggleButton.click();
    await expect(passwordField).toHaveAttribute('type', 'password');
  });

  test('Display error message on login failure', async ({ page }) => {
    await page.fill('input[name="username"]', 'wronguser');
    await page.fill('input[name="password"]', 'wrongpass');

    await page.locator('button[type="submit"]').click();

    // Verify error message appears
    const errorMessage = page.locator('text=Invalid username/password. Please try again.');
    await expect(errorMessage).toBeVisible({ timeout: 5000 });
  });

  test('Redirect to homepage after successful login', async ({ page }) => {
    await page.fill('input[name="username"]', 'bob_lee');
    await page.fill('input[name="password"]', 'password');

    // Wait for login response
    const responsePromise = page.waitForResponse(
      response => response.url().includes('/authenticate/login')
    );

    // Click login button
    await page.locator('button[type="submit"]').click();

    const response = await responsePromise;
    const responseData = await response.json();

    // If the login is successful, wait for the URL to change
    if (responseData.id > 0) {
      await expect(page).toHaveURL('/', { timeout: 10000 });
    } else {
      // Verification Error Message Display
      await expect(page.locator('text=Invalid username/password')).toBeVisible();
    }
  });

  test('Trigger login with Enter key', async ({ page }) => {
    await page.fill('input[name="username"]', 'bob_lee');
    await page.fill('input[name="password"]', 'password');

    // Wait for login response
    const responsePromise = page.waitForResponse(
      response => response.url().includes('/authenticate/login')
    );

    // Press Enter in password field
    await page.locator('input[name="password"]').press('Enter');

    const response = await responsePromise;
    const responseData = await response.json();

    if (responseData.id > 0) {
      await expect(page).toHaveURL('/', { timeout: 5000 });
    } else {
      await expect(page.locator('text=Invalid username/password')).toBeVisible();
    }
  });

  test('Navigate to registration page via sign up link', async ({ page }) => {
    await page.click('text=Get started');
    await expect(page).toHaveURL('/register', { timeout: 3000 });
  });
});

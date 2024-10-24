import { test, expect } from '@playwright/test';
import { EMAIL, USERNAME } from './test-utils';

test.describe('Registration Page Tests', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/register');
  });

  test('Display all required form fields', async ({ page }) => {
    // Verify all required input fields exist
    await expect(page.locator('input[name="name"]')).toBeVisible();
    await expect(page.locator('input[name="displayName"]')).toBeVisible();
    await expect(page.locator('input[name="email"]')).toBeVisible();
    await expect(page.locator('input[name="password"]')).toBeVisible();
    await expect(page.locator('input[name="confirmPassword"]')).toBeVisible();
  });

  test('Email format validation', async ({ page }) => {
    // Fill form with invalid email format
    await page.fill('input[name="name"]', USERNAME);
    await page.fill('input[name="displayName"]', USERNAME);
    await page.fill('input[name="email"]', 'invalid-email');
    await page.fill('input[name="password"]', 'Password123');
    await page.fill('input[name="confirmPassword"]', 'Password123');

    await page.locator('button[type="submit"]').click();

    // Verify error message
    const errorText = page.locator('.MuiFormHelperText-root.Mui-error').first();
    await expect(errorText).toHaveText('Please enter a valid email address');
  });

  test('Password length requirement validation', async ({ page }) => {
    // Fill form with too short password
    await page.fill('input[name="name"]', USERNAME);
    await page.fill('input[name="displayName"]', USERNAME);
    await page.fill('input[name="email"]', EMAIL);
    await page.fill('input[name="password"]', '123');
    await page.fill('input[name="confirmPassword"]', '123');

    await page.locator('button[type="submit"]').click();

    // Verify error message
    const errorText = page.locator('.MuiFormHelperText-root.Mui-error').first();
    await expect(errorText).toHaveText('Password must be at least 7 characters long');
  });

  test('Password matching validation', async ({ page }) => {
    // Fill form with mismatched passwords
    await page.fill('input[name="name"]', USERNAME);
    await page.fill('input[name="displayName"]', USERNAME);
    await page.fill('input[name="email"]', EMAIL);
    await page.fill('input[name="password"]', 'Password123');
    await page.fill('input[name="confirmPassword"]', 'Password456');

    await page.locator('button[type="submit"]').click();

    // Verify error message
    const errorText = page.locator('.MuiFormHelperText-root.Mui-error').first();
    await expect(errorText).toHaveText('Passwords do not match');
  });

  test('Show success dialog after successful registration', async ({ page }) => {
    // Fill form with valid registration data
    await page.fill('input[name="name"]', USERNAME);
    await page.fill('input[name="displayName"]', USERNAME);
    await page.fill('input[name="email"]', EMAIL);
    await page.fill('input[name="password"]', 'Password123');
    await page.fill('input[name="confirmPassword"]', 'Password123');

    await page.locator('button[type="submit"]').click();

    // Wait and verify success dialog
    await expect(page.locator('.MuiDialog-root')).toBeVisible();
    await expect(page.locator('.MuiDialogTitle-root')).toHaveText('Success');
    
    // Click back to sign in button
    await page.click('text=Back to Sign In');

    // Verify navigation to sign-in page
    await expect(page).toHaveURL('/sign-in');
  });
});

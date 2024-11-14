import { test, expect } from '@playwright/test';

test.describe('Ingredients Page Tests', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.fill('input[name="username"]', 'bob_lee');
    await page.fill('input[name="password"]', 'password');

    // Click login button
    await page.locator('button[type="submit"]').click();

    // Wait for login response
    await page.waitForResponse((response) => response.url().includes('/authenticate/login'));
  });

  test('Recipe creation', async ({ page }) => {
    // Click the first Inventory button
    await page.locator('a:has-text("Inventory")').nth(0).click();

    // Click New ingredient button
    await page.locator('button:has-text("New ingredient")').click();

    // expect url to be inventory/new
    expect(page.url()).toContain('/inventory/new');

    await page.locator('input[placeholder="e.g. banana"]').fill('pepper');
    await page.locator('input[placeholder="e.g. 35"]').fill('3');
    await page.fill('input[name="unit"]','g');
    await page.locator('input[type="date"].MuiInputBase-input.MuiOutlinedInput-input')
        .fill('2024-11-18');
    const addIngredientButton = page.locator('button:has-text("Add Ingredient")');
    await page.locator('button:has-text("Add Ingredient")').waitFor({ state: 'visible' });
    await addIngredientButton.click();
    // wait for confirm button
    const confirmButton = page.locator('button:has-text("Confirm")');
    await confirmButton.waitFor({ state: 'visible' });
    await confirmButton.click();
  });
});
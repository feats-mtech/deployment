import { test, expect } from '@playwright/test';

test.describe('Recipe Page Tests', () => {
    test.beforeEach(async ({ page }) => {
        await page.goto('/');
    });

    test('Display required login form fields', async ({ page }) => {
        await page.fill('input[name="username"]', 'bob_lee');
        await page.fill('input[name="password"]', 'password');

        // Wait for login response
        const responsePromise = page.waitForResponse(
            response => response.url().includes('/authenticate/login')
        );

        // Click login button
        await page.locator('button[type="submit"]').click();

        // Wait for login response to complete
        await responsePromise;

        // Click the first Recipes button
        await page.locator('a:has-text("Recipes")').nth(0).click();

        // Click Create button
        await page.locator('button:has-text("Create Recipe")').click();

        // Verify if required fields are visible
        await expect(page.locator('input[name="cookingTimeInMin"]')).toBeVisible();
        await expect(page.locator('input[name="name"]')).toBeVisible();

        // await expect(page.locator('textarea[name="description"]')).toBeVisible();
        // await expect(page.locator('input[name="difficultyLevel"]')).toBeVisible();
    });

    test('fill parameters', async ({ page }) => {
        await page.fill('input[name="username"]', 'bob_lee');
        await page.fill('input[name="password"]', 'password');
        await page.locator('button[type="submit"]').click();
        await page.locator('a:has-text("Recipes")').nth(0).click();
        await page.locator('button:has-text("Create Recipe")').click();

        await page.fill('input[name="name"]',"mala hotpot");

        // // 定位输入框
        // const imageInput = page.locator('#outlined-required');
        // 等待元素加载
        await page.waitForSelector('input[name="image"]');
        // // 填入图片 URL 或相关文本
        // await imageInput.fill('https://example.com/image.jpg');  // 替换为需要的内容
        await page.fill('input[name="image"]',"https://example.com/image.jpg")

        // // 定位 textarea 输入框
        // const descriptionTextarea = page.locator('#outlined-textarea');
        //
        // // 填入描述文本
        // await descriptionTextarea.fill('This is a sample description for the recipe.');
        await page.fill('textarea[name="description"]','This is a sample description for the recipe.')

        // ingredient name
        await page.fill('input[aria-invalid="false"][role="combobox"]', 'Sample Text');

        // // 定位输入框
        // const numberInput = page.locator('#\\:rhf\\:');  // 使用转义符处理特殊字符 ":"
        // // 填入数值
        // await numberInput.fill('100');  // 替换为你需要的数字值

        // await page.fill('[id=":rhf:"]','11')

        // 选择并点击 3 星评分
        // 使用 CSS 选择器定位元素
        const targetElementCSS = '#root__layout > div.layout__has__sidebar.MuiBox-root.css-7d7xpv > main > div > div > div > div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-12.MuiGrid-grid-sm-12.css-1idn90j-MuiGrid-root > div > div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-7.MuiGrid-grid-sm-8.css-32sjt2-MuiGrid-root > div > div.MuiGrid-root.MuiGrid-item.MuiGrid-grid-xs-10.css-1vu0w6-MuiGrid-root > span.MuiRating-root.MuiRating-sizeMedium.css-1yyqq0c-MuiRating-root > label:nth-child(5)';
        await page.click(targetElementCSS);  // 执行点击操作

        // Click dropdown button to open options
        const dropdownButton = page.locator('button[aria-label="Open"]');
        await dropdownButton.click();

        // Select an option, e.g., first option
        await page.locator('li[role="option"]:has-text("Local")').click();

        const publishButton = page.locator('button:has-text("Publish Recipe")');
        await publishButton.click();
    });


});
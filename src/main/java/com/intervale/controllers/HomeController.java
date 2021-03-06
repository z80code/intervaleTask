package com.intervale.controllers;

import com.google.gson.Gson;
import com.intervale.models.Brand;
import com.intervale.models.Card;
import com.intervale.models.Currency;
import com.intervale.models.MoneyTransfer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Home-контроллер получающий GET запросы
 * на адрес: localhost:8080/
 */

@Controller
public class HomeController {

    /**
     * @param model - объект для передачи параметров на View
     * @return - шаблон страницы, отображаемый клиенту
     */
    @GetMapping("/")
    public String home(Model model) {
        Gson gson = new Gson();
       List<String> currencies = Arrays.
                stream(Currency.values())
                .map(Enum::toString)
                .collect(Collectors.toList());

        List<String> brands = Arrays.
                stream(Brand.values())
                .map(Enum::toString)
                .collect(Collectors.toList());
        Brand[] list1 = Brand.values();

        int year = LocalDate.now().getYear();
        List<Integer> years = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            years.add(year + i);
        }

        model.addAttribute("currencies", gson.toJson(currencies));
        model.addAttribute("years", gson.toJson(years));
        model.addAttribute("brands", gson.toJson(brands));
        MoneyTransfer moneyTransfer = new MoneyTransfer(0,
                new Card(Brand.VISA, 0, "", System.currentTimeMillis()),
                new Card(Brand.VISA, 0, "", System.currentTimeMillis()),
                System.currentTimeMillis(),
                Currency.RUB,
                new BigDecimal(0),
                new BigDecimal(0)
        );
        model.addAttribute("mt", gson.toJson(moneyTransfer));

        return "home";
    }
}

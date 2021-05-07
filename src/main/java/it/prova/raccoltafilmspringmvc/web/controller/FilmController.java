package it.prova.raccoltafilmspringmvc.web.controller;

import java.util.List;

import javax.validation.Valid;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import it.prova.raccoltafilmspringmvc.model.Regista;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import it.prova.raccoltafilmspringmvc.model.Film;
import it.prova.raccoltafilmspringmvc.service.FilmService;
import it.prova.raccoltafilmspringmvc.service.RegistaService;

@Controller
@RequestMapping(value = "/film")
public class FilmController {

	@Autowired
	private FilmService filmService;
	@Autowired
	private RegistaService registaService;

	@GetMapping
	public ModelAndView listAllFilms() {
		ModelAndView mv = new ModelAndView();
		List<Film> films = filmService.listAllElements();
		mv.addObject("film_list_attribute", films);
		mv.setViewName("film/list");
		return mv;
	}

	@GetMapping("/insert")
	public String createFilm(Model model) {
		model.addAttribute("insert_film_attr", new Film());
		return "film/insert";
	}

	@PostMapping("/save")
	public String saveFilm(@Valid @ModelAttribute("insert_film_attr") Film film, BindingResult result,
			RedirectAttributes redirectAttrs) {

		// se il regista è valorizzato dobbiamo provare a caricarlo perché
		// ci aiuta in pagina
		if (film.getRegista() != null && film.getRegista().getId() != null)
			film.setRegista(registaService.caricaSingoloElemento(film.getRegista().getId()));

		if (result.hasErrors()) {
			return "film/insert";
		}
		filmService.inserisciNuovo(film);

		redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente");
		return "redirect:/film";
	}

	@GetMapping("/search")
	public String searchFilm(ModelMap model) {
		model.addAttribute("registi_list_attribute", registaService.listAllElements());
		return "film/search";
	}

	@PostMapping("/list")
	public String listFilm(Film filmExample, ModelMap model) {
		List<Film> films = filmService.findByExample(filmExample);
		model.addAttribute("film_list_attribute", films);
		return "film/list";
	}

	@GetMapping("/show/{idFilm}")
	public String showFilm(@PathVariable(required = true) Long idFilm, Model model) {
		model.addAttribute("show_film_attr", filmService.caricaSingoloElementoEager(idFilm));
		return "film/show";
	}

	@GetMapping("/edit/{idFilm}")
	public String showEditFilm(@PathVariable(required = true) Long idFilm, Model model) {
		model.addAttribute("registi_list_attribute", registaService.listAllElements());
		model.addAttribute("edit_film_attribute", filmService.caricaSingoloElementoEager(idFilm));
		return "film/edit";
	}


	@PostMapping("/edit/saveEdit")
	public String editFilm(@Valid @ModelAttribute("edit_film_attribute") Film film, BindingResult result,
						   RedirectAttributes redirectAttrs) {

		if (film.getRegista() != null && film.getRegista().getId() != null)
			film.setRegista(registaService.caricaSingoloElemento(film.getRegista().getId()));

		if (result.hasErrors()) {
			return "film/edit";
		}

		filmService.aggiorna(film);

		redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente");
		return "redirect:/film";

	}

	@GetMapping("/delete/{idFilm}")
	public String showDeleteFilm(@PathVariable(required = true) Long idFilm, Model model) {
		model.addAttribute("film_delete_attribute", filmService.caricaSingoloElemento(idFilm));
		return "film/delete";
	}

	@PostMapping("/delete/deleteFilm")
	public String deleteFilm(@ModelAttribute("film_delete_attribute") Film film, RedirectAttributes redirectAttrs) {
		filmService.rimuovi(film);
		redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente");
		return "redirect:/film";
	}

	@GetMapping(value = "/edit/searchRegistiAjax", produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody String searchRegista(@RequestParam String term) {

		List<Regista> listaRegistaByTerm = registaService.cercaByCognomeENomeILike(term);
		return buildJsonResponse(listaRegistaByTerm);
	}

	private String buildJsonResponse(List<Regista> listaRegisti) {
		JsonArray ja = new JsonArray();

		for (Regista registaItem : listaRegisti) {
			JsonObject jo = new JsonObject();
			jo.addProperty("value", registaItem.getId());
			jo.addProperty("label", registaItem.getNome() + " " + registaItem.getCognome());
			ja.add(jo);
		}

		return new Gson().toJson(ja);
	}

}
